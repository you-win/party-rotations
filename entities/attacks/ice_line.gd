extends BaseAttack

const SPEED: float = 1.5

var target_position: Vector2
var velocity: Vector2

var spawn_time: float = 1.0
var spawn_counter: float = 0.0

var is_master := true

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	velocity = (target_position - global_position).normalized() * SPEED * 60

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

	if is_master:
		spawn_counter += delta
		if spawn_counter > spawn_time:
			spawn_counter = 0.0
			var new_ice = load("res://entities/attacks/ice_line.tscn").instance()
			new_ice.target_group = GameManager.ENEMY_GROUP
			new_ice.initial_position = global_position
			new_ice.lifetime = 5.0
			new_ice.damage = damage
			new_ice.effect = effect
			new_ice.target_position = global_position
			new_ice.is_master = false
			get_parent().get_parent().call_deferred("add_child", new_ice)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


