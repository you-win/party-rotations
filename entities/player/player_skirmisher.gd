extends BasePlayerUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 4.0
	skill_2_cd = 5.0
	skill_3_cd = 8.0
	skill_4_cd = 25.0

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
	"""
	Dagger throw
	
	Throw a dagger at a given position
	"""
	.skill_1()
	pass

func skill_2() -> void:
	"""
	Encouragement
	
	Reduce cooldowns for the entire party by a small amount
	"""
	.skill_2()
	pass

func skill_3() -> void:
	"""
	Smoke bomb
	
	Throw a smoke bomb at a given position, granting invulnerability for
	a short duration
	"""
	.skill_3()
	pass

func skill_4() -> void:
	"""
	Tactical reinforcement
	
	Call in reinforcements which will strike the given position in many lines
	"""
	.skill_4()
	pass
