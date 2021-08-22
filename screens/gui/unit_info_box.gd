class_name UnitInfoBox
extends PanelContainer

export var q_progress_path: NodePath
export var w_progress_path: NodePath
export var e_progress_path: NodePath
export var r_progress_path: NodePath
export var unit_health_bar_path: NodePath

onready var q_progress: ProgressBar = get_node(q_progress_path)
onready var w_progress: ProgressBar = get_node(w_progress_path)
onready var e_progress: ProgressBar = get_node(e_progress_path)
onready var r_progress: ProgressBar = get_node(r_progress_path)
onready var unit_health_bar: ProgressBar = get_node(unit_health_bar_path)

onready var skill_bars: Array = [
	q_progress,
	w_progress,
	e_progress,
	r_progress
]

var unit: BasePlayerUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	if not unit:
		yield(get_tree(), "idle_frame")
	q_progress.max_value = unit.skill_1_cd
	w_progress.max_value = unit.skill_2_cd
	e_progress.max_value = unit.skill_3_cd
	r_progress.max_value = unit.skill_4_cd
	unit_health_bar.max_value = unit.health

func _process(delta: float) -> void:
	q_progress.value = unit.skill_1_counter
	w_progress.value = unit.skill_2_counter
	e_progress.value = unit.skill_3_counter
	r_progress.value = unit.skill_4_counter
	
	for i in skill_bars:
		if i.value <= 0.0:
			i.value = i.max_value

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


