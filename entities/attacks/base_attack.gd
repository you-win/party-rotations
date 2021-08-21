class_name BaseAttack
extends Area2D

export var should_apply_damage := false

var lifetime: float
var lifetime_counter: float

var initial_position: Vector2
var initial_rotation: float
var target_group: String

var damage: float
var effect: int
var data

# Ensure we only affect each unit once while still allowing for multiple units to be hit
var collided_units: Array # String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	global_position = initial_position
	global_rotation = initial_rotation
	
	$AnimationPlayer.play("Run")
	
	if should_apply_damage:
		connect("body_entered", self, "_on_area_entered")

func _process(delta: float) -> void:
	lifetime_counter += delta
	if lifetime_counter > lifetime:
		queue_free()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_area_entered(body: Node) -> void:
	if (body.is_in_group(target_group) and not body.name in collided_units):
		# We can assume these nodes will have a receive_attack function
		body.receive_damage(damage, effect, data)
		collided_units.append(body.name)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


