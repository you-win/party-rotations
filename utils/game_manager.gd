extends Node

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

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
