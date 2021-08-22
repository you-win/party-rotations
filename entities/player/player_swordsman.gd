extends BasePlayerUnit

const Slash: Resource = preload("res://entities/attacks/slash.tscn")

const ShieldsUp: Resource = preload("res://entities/attacks/shields_up.tscn")

const Snacc: Resource = preload("res://entities/attacks/snacc.tscn")

const SwordTime: Resource = preload("res://entities/attacks/sword_time.tscn")

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 4.0
	skill_2_cd = 6.0
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
	Slash
	
	Slash in a given direction
	"""
	.skill_1()
	
	var slash: BaseAttack = Slash.instance()

	slash.target_group = GameManager.ENEMY_GROUP

	slash.initial_position = global_position
	slash.initial_rotation = get_global_mouse_position().angle_to_point(global_position)

	slash.lifetime = 0.5

	slash.damage = 5.0 * damage_multiplier
	slash.effect = AttackEffect.PUSH
	slash.data = global_position

	line.add_attack(slash)

func skill_2() -> void:
	"""
	Shields up
	
	Bash in a given direction and block damage for a short duration
	"""
	.skill_2()
	
	var shields_up: BaseAttack = ShieldsUp.instance()

	shields_up.target_group = GameManager.ENEMY_GROUP

	shields_up.initial_position = global_position
	shields_up.initial_rotation = get_global_mouse_position().angle_to_point(global_position)

	shields_up.lifetime = 0.5

	shields_up.damage = 3.0 * damage_multiplier
	shields_up.effect = AttackEffect.PUSH
	shields_up.data = shields_up.initial_position

	line.add_attack(shields_up)

	for unit in line.units:
		damage_reduction -= 0.5
		damage_reduction_time += 10.0

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
	var sword_time: BaseAttack = SwordTime.instance()
	sword_time.initial_position = global_position
	sword_time.lifetime = 2.0
	line.add_attack(sword_time)

	for unit in line.units:
		unit.damage_multiplier += 0.5
		unit.damage_multiplier_time += 10.0
