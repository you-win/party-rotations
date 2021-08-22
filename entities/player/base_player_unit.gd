class_name BasePlayerUnit
extends BaseUnit

enum QueuedSkill { NONE = 0, SKILL_1, SKILL_2, SKILL_3, SKILL_4 }

const MIN_MOVE_DISTANCE: float = 1.0
const UNIT_SPACING: float = 10.0

const MOVE_SPEED: float = 100.0

# TODO Currently set directly by the line
var line

# Movement
var is_current := false

var position_to := Vector2.ZERO
var current_velocity := Vector2.ZERO

# Skills
var queued_skill: int = QueuedSkill.NONE

var skill_1_cd: float
var skill_1_counter: float = 0.0
var is_skill_1_on_cd := true

var skill_2_cd: float
var skill_2_counter: float = 0.0
var is_skill_2_on_cd := true

var skill_3_cd: float
var skill_3_counter: float = 0.0
var is_skill_3_on_cd := true

var skill_4_cd: float
var skill_4_counter: float = 0.0
var is_skill_4_on_cd := true

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	add_to_group(GameManager.PLAYER_GROUP)

func _physics_process(delta: float) -> void:
	var spacing: float = UNIT_SPACING
	if is_current:
		spacing = MIN_MOVE_DISTANCE
		
		if queued_skill != QueuedSkill.NONE:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	if global_position.distance_to(position_to) > spacing:
		move_and_slide((position_to - global_position).normalized() * MOVE_SPEED * 60 * delta)
	
	# Skill cooldown counters
	# We don't use timers here since some skills manipulate cooldowns
	if is_skill_1_on_cd:
		skill_1_counter += delta
		if skill_1_counter > skill_1_cd:
			skill_1_counter = 0
			is_skill_1_on_cd = false
	
	if is_skill_2_on_cd:
		skill_2_counter += delta
		if skill_2_counter > skill_2_cd:
			skill_2_counter = 0
			is_skill_2_on_cd = false
	
	if is_skill_3_on_cd:
		skill_3_counter += delta
		if skill_3_counter > skill_3_cd:
			skill_3_counter = 0
			is_skill_3_on_cd = false
	
	if is_skill_4_on_cd:
		skill_4_counter += delta
		if skill_4_counter > skill_4_cd:
			skill_4_counter = 0
			is_skill_4_on_cd = false

func _unhandled_input(event: InputEvent) -> void:
	if (queued_skill != QueuedSkill.NONE and event.is_action_pressed("primary_action")):
		match queued_skill:
			QueuedSkill.SKILL_1:
				skill_1()
			QueuedSkill.SKILL_2:
				skill_2()
			QueuedSkill.SKILL_3:
				skill_3()
			QueuedSkill.SKILL_4:
				skill_4()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func skill_1() -> void:
	is_skill_1_on_cd = true
	queued_skill = QueuedSkill.NONE

func skill_2() -> void:
	is_skill_2_on_cd = true
	queued_skill = QueuedSkill.NONE

func skill_3() -> void:
	is_skill_3_on_cd = true
	queued_skill = QueuedSkill.NONE

func skill_4() -> void:
	is_skill_4_on_cd = true
	queued_skill = QueuedSkill.NONE
