extends Node2D

const POSITION_COUNTER_MAX: float = 0.1

var update_position_counter: float = 0.0

var units: Array = []

var current_unit: BasePlayerUnit
var unit1: BasePlayerUnit
var unit2: BasePlayerUnit
var unit3: BasePlayerUnit
var unit4: BasePlayerUnit

var screen: Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	GameManager.line = self
	
	current_unit = unit1
	current_unit.is_current = true
	
	units.append(unit1)
	units.append(unit2)
	units.append(unit3)
	units.append(unit4)
	
	for unit in units:
		unit.line = self
		for unit_i in units:
			(unit as PhysicsBody2D).add_collision_exception_with(unit_i)

func _exit_tree() -> void:
	for unit in units:
		unit.queue_free()
	units.clear()
	
	if screen:
		screen.queue_free()

func _physics_process(delta: float) -> void:
	if units.empty():
		return
	if Input.is_action_pressed("secondary_action"):
		current_unit.position_to = get_global_mouse_position()
		current_unit.queued_skill = BasePlayerUnit.QueuedSkill.NONE
	
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
		if not current_unit.is_skill_1_on_cd:
			current_unit.queued_skill = BasePlayerUnit.QueuedSkill.SKILL_1
	elif event.is_action_pressed("skill_2"):
		if not current_unit.is_skill_2_on_cd:
			current_unit.queued_skill = BasePlayerUnit.QueuedSkill.SKILL_2
	elif event.is_action_pressed("skill_3"):
		if not current_unit.is_skill_3_on_cd:
			current_unit.queued_skill = BasePlayerUnit.QueuedSkill.SKILL_3
	elif event.is_action_pressed("skill_4"):
		if not current_unit.is_skill_4_on_cd:
			current_unit.queued_skill = BasePlayerUnit.QueuedSkill.SKILL_4

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _set_current_unit(unit: BasePlayerUnit) -> void:
	# Reset attributes on current unit
	current_unit.is_current = false
	current_unit.queued_skill = BasePlayerUnit.QueuedSkill.NONE
	
	# Transfer attributes to new unit
	unit.position_to = current_unit.position_to
	current_unit = unit
	current_unit.is_current = true
	units.erase(current_unit)
	units.push_front(current_unit)

###############################################################################
# Public functions                                                            #
###############################################################################

func add_attack(node: BaseAttack) -> void:
	screen.attacks.call_deferred("add_child", node)
