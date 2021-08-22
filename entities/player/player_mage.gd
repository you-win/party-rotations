extends BasePlayerUnit

const WaterBall: Resource = preload("res://entities/attacks/water_ball.tscn")

const BloodRush: Resource = preload("res://entities/attacks/blood_rush.tscn")

const PoisonGas: Resource = preload("res://entities/attacks/poison_gas.tscn")

const IceLine: Resource = preload("res://entities/attacks/ice_line.tscn")

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

	var mouse_pos: Vector2 = get_global_mouse_position()
	
	var water_ball: BaseAttack = WaterBall.instance()
	water_ball.target_group = GameManager.ENEMY_GROUP
	water_ball.initial_position = global_position
	water_ball.initial_rotation = mouse_pos.angle_to_point(global_position)
	water_ball.lifetime = 4.0

	water_ball.damage = 6.0 * damage_multiplier
	water_ball.effect = AttackEffect.NONE

	water_ball.target_position = mouse_pos

	line.add_attack(water_ball)

func skill_2() -> void:
	"""
	Blood rush
	
	Buff the party's attack for a medium duration, reduces cooldowns by
	a small duration
	"""
	.skill_2()
	
	var blood_rush: BaseAttack = BloodRush.instance()
	blood_rush.initial_position = global_position
	blood_rush.lifetime = 2.0

	line.add_attack(blood_rush)

	for unit in line.units:
		unit.skill_1_counter *= 1.2
		unit.skill_2_counter *= 1.2
		unit.skill_3_counter *= 1.2
		unit.skill_4_counter *= 1.2

func skill_3() -> void:
	"""
	Poison gas
	
	Create a cloud of poison at a given position
	"""
	.skill_3()
	
	var poison_gas: BaseAttack = PoisonGas.instance()
	poison_gas.target_group = GameManager.ENEMY_GROUP

	poison_gas.initial_position = get_global_mouse_position()
	
	poison_gas.lifetime = 1.0

	poison_gas.damage = 5.0 * damage_multiplier
	poison_gas.effect = AttackEffect.NONE

	line.add_attack(poison_gas)

func skill_4() -> void:
	"""
	Ice line
	
	Create a line of ice in a given direction that persists for a
	short duration
	"""
	.skill_4()
	
	var ice_line: BaseAttack = IceLine.instance()
	ice_line.target_group = GameManager.ENEMY_GROUP

	ice_line.initial_position = global_position

	ice_line.lifetime = 5.0

	ice_line.damage = 10.0 * damage_multiplier
	ice_line.effect = AttackEffect.NONE

	ice_line.target_position = get_global_mouse_position()

	line.add_attack(ice_line)
