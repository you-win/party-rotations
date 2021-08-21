extends BasePlayerUnit

const Snacc: Resource = preload("res://entities/attacks/snacc.tscn")

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 4.0
	skill_2_cd = 6.0
	skill_3_cd = 10.0
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
	Slash
	
	Slash in a given direction
	"""
	.skill_1()
	pass

func skill_2() -> void:
	"""
	Shields up
	
	Bash in a given direction and block damage for a short duration
	"""
	.skill_2()
	pass

func skill_3() -> void:
	"""
	Snacc
	
	Restore health for the party, increases defense for a short duration
	"""
	.skill_3()
	for unit in line.units:
		unit.health += 25.0
	
	var snacc: BaseAttack = Snacc.instance()
	snacc.initial_position = global_position
	snacc.lifetime = 2.0
	line.add_attack(snacc)

func skill_4() -> void:
	"""
	Sword time
	
	Increase damage dealt for the party and gain invulnerability for a
	short duration
	"""
	.skill_4()
	pass
