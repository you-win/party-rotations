extends BaseAttack

# TODO this is basically the same as throw_spears.gd

const SPEED: float = 2.0

var target_position: Vector2
var velocity: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	velocity = (target_position - global_position).normalized() * SPEED * 60

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


