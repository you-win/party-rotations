class_name BaseUnit
extends KinematicBody2D

var health: float = 100.0

enum AttackEffect { NONE = 0, PUSH, ROOT, STUN }

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func receive_damage(damage: float, effect: int, data) -> void:
	match effect:
		AttackEffect.PUSH:
			# data will be the push direction
			global_position -= (data.normalized() as Vector2) * 10.0 # TODO magic number
		AttackEffect.ROOT:
			# data will be the root duration
			pass
		AttackEffect.STUN:
			# data will be the stun duration
			pass
		_:
			GameManager.log_message("Unhandled AttackEffect", true)
