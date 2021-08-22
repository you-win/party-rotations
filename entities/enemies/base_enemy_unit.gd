class_name BaseEnemyUnit
extends BaseUnit

enum State { NONE, IDLE, CHASE, ATTACK }

var line

# State management
var last_state: int = State.NONE
var current_state: int = State.NONE
var state_switch_num: float = 4.0
var state_switch_count: float = 0.0
var is_state_locked := false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	add_to_group(GameManager.ENEMY_GROUP)
	
	if not GameManager.line:
		yield(get_tree(), "idle_frame")
	line = GameManager.line
	
	anim_player.play("Idle")

func _process(delta: float) -> void:
	if health <= 0:
		anim_player.play("Die")
	
	state_switch_count += delta
	if state_switch_count > state_switch_num:
		state_switch_count = 0.0
		_randomize_state()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_anim_finished(_anim_name: String) -> void:
	pass

###############################################################################
# Private functions                                                           #
###############################################################################

func _randomize_state() -> void:
	if is_state_locked:
		return
	var new_state: int = GameManager.rng.randi_range(1, State.size() - 1)
	if new_state == current_state:
		# Try not to attack too often
		new_state = State.CHASE
		if last_state == new_state:
			new_state = State.IDLE
	last_state = current_state
	current_state = new_state

###############################################################################
# Public functions                                                            #
###############################################################################


