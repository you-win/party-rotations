extends Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	var line = load("res://entities/player/player_unit_line.tscn").instance()
	line.unit1 = load("res://entities/player/player_spearman.tscn").instance()
	line.unit2 = load("res://entities/player/player_spearman.tscn").instance()
	line.unit3 = load("res://entities/player/player_spearman.tscn").instance()
	line.unit4 = load("res://entities/player/player_spearman.tscn").instance()
	
	call_deferred("add_child", line.unit1)
	call_deferred("add_child", line.unit2)
	call_deferred("add_child", line.unit3)
	call_deferred("add_child", line.unit4)
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


