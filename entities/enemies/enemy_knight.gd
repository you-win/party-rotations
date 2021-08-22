extends BaseEnemyUnit

const MOVE_SPEED: float = 20.0
const CHARGE_SPEED: float = 200.0
const SPACING: float = 10.0

const DAMAGE: float = 20.0

onready var sword_parent: Node2D = $SwordParent
onready var sword_area: Area2D = $SwordParent/Pivot/Sword/Area2D
onready var charge_area: Area2D = $ChargeArea
onready var charge_area_shape: CollisionShape2D = $ChargeArea/CollisionShape2D

var is_charging := false
var charge_to_pos := Vector2.ZERO

var collided_units: Array = [] # String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	health = 100.0
	current_state = State.IDLE
	
	while not line:
		yield(get_tree(), "idle_frame")

	sword_area.connect("body_entered", self, "_on_area_entered")
	charge_area.connect("body_entered", self, "_on_area_entered")

func _physics_process(delta: float) -> void:
	if health <= 0.0:
		return
	match current_state:
		State.IDLE:
			if anim_player.current_animation != "Idle":
				anim_player.play("Idle")
		State.CHASE:
			if anim_player.current_animation != "Idle":
				anim_player.play("Idle")
			if global_position.distance_to(line.current_unit.global_position) > SPACING:
				move_and_slide((line.current_unit.global_position - global_position).normalized()
						* MOVE_SPEED * 60 * delta)
		State.ATTACK:
			if not is_state_locked:
				is_state_locked = true
				match GameManager.rng.randi_range(0, 1):
					0:
						anim_player.play("Charge")
					1:
						sword_parent.rotation = line.current_unit.global_position.angle_to_point(
								global_position)
						anim_player.play("Slash")
			# Currently attacking
			elif is_charging:
				if global_position.distance_to(charge_to_pos) > SPACING:
					move_and_slide((charge_to_pos - global_position).normalized()
							* CHARGE_SPEED * 60 * delta)
				else:
					is_charging = false
					is_state_locked = false
					charge_area_shape.disabled = true
					_attack_complete()
		_:
			GameManager.log_message("Unhandled state", true)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_anim_finished(anim_name: String) -> void:
	match anim_name:
		"Idle":
			pass
		"Slash":
			is_state_locked = false
			_attack_complete()
		"Charge":
			is_charging = true
			charge_to_pos = line.current_unit.global_position
		"Die":
			emit_signal("killed")
			queue_free()
		_:
			GameManager.log_message("Unhandled anim_name: %s" % anim_name, true)

func _on_area_entered(body: Node) -> void:
	if (body.is_in_group(GameManager.PLAYER_GROUP) and body == line.current_unit):
		if not body.name in collided_units:
			body.receive_damage(DAMAGE, AttackEffect.PUSH, global_position)
			collided_units.append(body.name)


###############################################################################
# Private functions                                                           #
###############################################################################

func _attack_complete() -> void:
	collided_units.clear()
	state_switch_count = 0
	_randomize_state()

###############################################################################
# Public functions                                                            #
###############################################################################


