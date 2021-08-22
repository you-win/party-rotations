class_name BaseUnit
extends KinematicBody2D

enum AttackEffect { NONE = 0, PUSH, ROOT, STUN }

var health: float = 100.0

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var health_bar: ProgressBar = $HealthBar

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	connect("ready", self, "_post_ready")
	anim_player.connect("animation_finished", self, "_on_anim_finished")

func _process(delta: float) -> void:
	health_bar.value = health

###############################################################################
# Connections                                                                 #
###############################################################################

func _post_ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func _on_anim_finished(_anim_name: String) -> void:
	pass

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
