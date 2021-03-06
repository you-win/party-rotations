extends Node2D

onready var units: Node = $Units
onready var attacks: Node = $Attacks

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	var line = load("res://entities/player/player_unit_line.tscn").instance()
	line.unit1 = load("res://entities/player/player_spearman.tscn").instance()
	line.unit2 = load("res://entities/player/player_swordsman.tscn").instance()
	line.unit3 = load("res://entities/player/player_mage.tscn").instance()
	line.unit4 = load("res://entities/player/player_druid.tscn").instance()
	
	line.screen = self
	
	units.call_deferred("add_child", line.unit1)
	units.call_deferred("add_child", line.unit2)
	units.call_deferred("add_child", line.unit3)
	units.call_deferred("add_child", line.unit4)
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


