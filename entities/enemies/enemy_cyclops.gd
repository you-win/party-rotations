extends BaseEnemyUnit

const MOVE_SPEED: float = 10.0
const SPACING: float = 10.0

const DAMAGE: float = 20.0

onready var swipe_parent: Node2D = $SwipeParent
onready var swipe_area: Area2D = $SwipeParent/Pivot/Swipe/Area2D
onready var pound_area: Area2D = $PoundParent/Pivot/Sprite/Area2D
onready var pound_shape: CollisionShape2D = $PoundParent/Pivot/Sprite/Area2D/CollisionShape2D

var collided_units: Array = [] # String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	health = 5000.0
	current_state = State.IDLE

	swipe_area.connect("body_entered", self, "_on_area_entered")
	pound_area.connect("body_entered", self, "_on_area_entered")

func _physics_process(delta: float) -> void:
	if health <= 0.0:
		return
	# TODO HACK
	if not line:
		line = GameManager.line
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
						anim_player.play("Pound")
						pound_shape.global_position = line.current_unit.global_position
					1:
						swipe_parent.rotation = line.current_unit.global_position.angle_to_point(
								global_position)
						anim_player.play("Swipe")
		_:
			GameManager.log_message("Unhandled state", true)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_anim_finished(anim_name: String) -> void:
	match anim_name:
		"Idle":
			pass
		"Pound":
			_attack_complete()
		"Swipe":
			_attack_complete()
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
	is_state_locked = false
	state_switch_count = 0
	_randomize_state()

###############################################################################
# Public functions                                                            #
###############################################################################


