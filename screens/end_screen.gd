extends CanvasLayer

var click_count: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_action"):
		click_count += 1
		if click_count > 1:
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


