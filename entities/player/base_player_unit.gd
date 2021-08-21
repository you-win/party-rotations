class_name BasePlayerUnit
extends BaseUnit

const MIN_MOVE_DISTANCE: float = 1.0
const MOVE_SPEED: float = 100.0

var is_current := false
var position_to := Vector2.ZERO

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if global_position.distance_to(position_to) > MIN_MOVE_DISTANCE:
		move_and_slide((position_to - global_position).normalized() * MOVE_SPEED)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func skill_1() -> void:
	pass

func skill_2() -> void:
	pass

func skill_3() -> void:
	pass

func skill_4() -> void:
	pass
