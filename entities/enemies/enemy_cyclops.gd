extends BaseEnemyUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	health = 1000.0
	current_state = State.IDLE

func _physics_process(delta: float) -> void:
	match current_state:
		State.IDLE:
			if anim_player.current_animation != "Idle":
				anim_player.play("Idle")
		State.CHASE:
			pass
		State.ATTACK:
			if not is_state_locked:
				# Lock the state so we can finish our attack
				is_state_locked = true
		_:
			GameManager.log_message("Unhandled state", true)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_anim_finished(anim_name: String) -> void:
	match anim_name:
		"Idle":
			pass
		"Swipe":
			is_state_locked = false
			state_switch_count = 0
			_randomize_state()
		"Die":
			queue_free()
		_:
			GameManager.log_message("Unhandled anim_name: %s" % anim_name, true)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


