extends Node

const PLAYER_GROUP := "Player"
const ENEMY_GROUP := "Enemy"

var rng := RandomNumberGenerator.new()

# Easy access for AI cheating
var line

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	rng.randomize()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	var hand_cursor: Resource = load("res://assets/cursors/pointing_hand.tres")
	Input.set_custom_mouse_cursor(hand_cursor, Input.CURSOR_ARROW)
	
	var sword_cursor: Resource = load("res://assets/cursors/pointing_sword.tres")
	Input.set_custom_mouse_cursor(sword_cursor, Input.CURSOR_POINTING_HAND)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		get_tree().quit()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func log_message(message: String, is_error: bool = false) -> void:
	if is_error:
		message = "[ERROR] %s" % message
		assert(false, message)
	print(message)
	emit_signal("message_logged", message)

func not_yet_implemented() -> void:
	var message := "Method not yet implemented"
	assert(false, message)
	print_debug(message)
