extends Node2D

const POSITION_COUNTER_MAX: float = 0.25

var update_position_counter: float = 0.0

var units: Array = []

var current_unit: BasePlayerUnit
var unit1: BasePlayerUnit
var unit2: BasePlayerUnit
var unit3: BasePlayerUnit
var unit4: BasePlayerUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	current_unit = unit1
	current_unit.is_current = true
	
	units.append(unit1)
	units.append(unit2)
	units.append(unit3)
	units.append(unit4)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("primary_action"):
		units[0].position_to = get_global_mouse_position()
	
	update_position_counter += delta
	if update_position_counter > POSITION_COUNTER_MAX:
		update_position_counter = 0.0
		# Do these in reverse order
		units[3].position_to = units[2].global_position
		units[2].position_to = units[1].global_position
		units[1].position_to = units[0].global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_to_unit_1"):
		_set_current_unit(unit1)
	elif event.is_action_pressed("switch_to_unit_2"):
		_set_current_unit(unit2)
	elif event.is_action_pressed("switch_to_unit_3"):
		_set_current_unit(unit3)
	elif event.is_action_pressed("switch_to_unit_4"):
		_set_current_unit(unit4)
	
	elif event.is_action_pressed("skill_1"):
		current_unit.skill_1()
	elif event.is_action_pressed("skill_2"):
		current_unit.skill_2()
	elif event.is_action_pressed("skill_3"):
		current_unit.skill_3()
	elif event.is_action_pressed("skill_4"):
		current_unit.skill_4()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _set_current_unit(unit: BasePlayerUnit) -> void:
	current_unit = unit
	current_unit.is_current = true
	units.erase(current_unit)
	units.push_front(current_unit)

###############################################################################
# Public functions                                                            #
###############################################################################


