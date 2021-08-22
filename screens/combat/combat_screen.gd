class_name CombatScreen
extends BaseScreen

export var unit1_info_path: NodePath
export var unit2_info_path: NodePath
export var unit3_info_path: NodePath
export var unit4_info_path: NodePath
export var player_spawn_path: NodePath

onready var unit1_info: UnitInfoBox = get_node(unit1_info_path)
onready var unit2_info: UnitInfoBox = get_node(unit2_info_path)
onready var unit3_info: UnitInfoBox = get_node(unit3_info_path)
onready var unit4_info: UnitInfoBox = get_node(unit4_info_path)
onready var player_spawn: Node2D = get_node(player_spawn_path)

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	unit1_info.unit = line.unit1
	unit2_info.unit = line.unit2
	unit3_info.unit = line.unit3
	unit4_info.unit = line.unit4
	
	while line.units.empty():
		yield(get_tree(), "idle_frame")
	for unit in line.units:
		unit.global_position = player_spawn.global_position
		unit.position_to = unit.global_position

func _exit_tree() -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


