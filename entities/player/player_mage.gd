extends BasePlayerUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 5.0
	skill_2_cd = 8.0
	skill_3_cd = 6.0
	skill_4_cd = 20.0

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
	Waterball
	
	Cast a waterball that damages the first enemy it hits
	"""
	.skill_1()
	pass

func skill_2() -> void:
	"""
	Blood rush
	
	Buff the party's attack for a medium duration, reduces cooldowns by
	a small duration
	"""
	.skill_2()
	pass

func skill_3() -> void:
	"""
	Poison gas
	
	Create a cloud of poison at a given position
	"""
	.skill_3()
	pass

func skill_4() -> void:
	"""
	Ice line
	
	Create a line of ice in a given direction that persists for a
	short duration
	"""
	.skill_4()
	pass
