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
var collided_units: Array = [] # String

var impact_sound: AudioStreamPlayer2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	global_position = initial_position
	global_rotation = initial_rotation
	
	$AnimationPlayer.play("Run")
	
	if should_apply_damage:
		connect("body_entered", self, "_on_area_entered")
		
		match GameManager.rng.randi_range(0, 3):
			0:
				impact_sound = load("res://assets/audio/impact0.tscn").instance()
			1:
				impact_sound = load("res://assets/audio/impact1.tscn").instance()
			2:
				impact_sound = load("res://assets/audio/impact2.tscn").instance()
			3:
				impact_sound = load("res://assets/audio/impact3.tscn").instance()
		
		call_deferred("add_child", impact_sound)

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
		
		var visible_damage: BaseAttack
		match GameManager.rng.randi_range(0, 2):
			0:
				visible_damage = load("res://entities/attacks/visible_damage0.tscn").instance()
			1:
				visible_damage = load("res://entities/attacks/visible_damage1.tscn").instance()
			2:
				visible_damage = load("res://entities/attacks/visible_damage2.tscn").instance()
			_:
				GameManager.log_message("Unhandled visible_damage type", true)
				return
		
		visible_damage.lifetime = 1.0
		get_parent().get_parent().call_deferred("add_child", visible_damage)
		
		yield(visible_damage, "ready")
		visible_damage.global_position = body.global_position
		
		if impact_sound:
			impact_sound.play()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


