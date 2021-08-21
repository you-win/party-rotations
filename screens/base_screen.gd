extends Node2D

const PlayerUnitLine: Resource = preload("res://entities/player/player_unit_line.tscn")

onready var units: Node = $Units

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	SignalBroadcaster.current_level = self
	
	var line: Node2D = PlayerUnitLine.instance()
	for i in GameManager.unit_layout.size():
		match i:
			0:
				line.unit1 = GameManager.unit_layout[i]
			1:
				line.unit2 = GameManager.unit_layout[i]
			2:
				line.unit3 = GameManager.unit_layout[i]
			3:
				line.unit4 = GameManager.unit_layout[i]
			_:
				GameManager.log_message("Unhandled unit layout", true)
	
	call_deferred("add_child", line)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


