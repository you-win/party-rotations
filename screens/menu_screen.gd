extends Node2D

const WIGGLE_COUNT_MAX: float = 4.0

export var start_button_path: NodePath
export var quit_button_path: NodePath
export var animation_player_path: NodePath

onready var start_button: Button = get_node(start_button_path)
onready var quit_button: Button = get_node(quit_button_path)
onready var animation_player: AnimationPlayer = get_node(animation_player_path)

onready var hover_sound: AudioStreamPlayer2D = $HoverSound

var should_count_wiggle := true
var wiggle_counter: float = 0.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	start_button.connect("pressed", self, "_on_start_button_pressed")
	quit_button.connect("pressed", self, "_on_quit_button_pressed")
	
	start_button.connect("mouse_entered", self, "_on_mouseover")
	quit_button.connect("mouse_entered", self, "_on_mouseover")
	
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	animation_player.play("TitleWiggle")

func _physics_process(delta: float) -> void:
	if should_count_wiggle:
		wiggle_counter += delta
		if wiggle_counter > WIGGLE_COUNT_MAX:
			animation_player.play("TitleSpin")
			wiggle_counter = 0
			should_count_wiggle = false

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_start_button_pressed() -> void:
	get_tree().change_scene("res://screens/combat/knight_screen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_mouseover() -> void:
	hover_sound.pitch_scale = 1.0 + GameManager.rng.randf_range(-0.5, 0.5)
	hover_sound.play()

func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"TitleSpin":
			animation_player.play("TitleWiggle")
			should_count_wiggle = true
		_:
			GameManager.log_message("Unhandled anim")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


