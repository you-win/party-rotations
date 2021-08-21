extends BasePlayerUnit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 5.0
	skill_2_cd = 4.0
	skill_3_cd = 10.0
	skill_4_cd = 15.0

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
	Grasping roots
	
	Damage enemies at a given location and stop their movement for a duration
	"""
	.skill_1()
	pass

func skill_2() -> void:
	"""
	Miracle growth
	
	Create a tree at a given position that can block an attack
	Trees will explode when destroyed or after a medium duration
	"""
	.skill_2()
	pass

func skill_3() -> void:
	"""
	Blasphemous Totem
	
	Create a totem at a given position that heals the party for a duration
	"""
	.skill_3()
	pass

func skill_4() -> void:
	"""
	Hidden path
	
	Quickly travel to a location, creating Miracle Growth trees along the way
	"""
	.skill_4()
	pass
