extends BasePlayerUnit

const Thrust0: Resource = preload("res://entities/attacks/thrust0.tscn")
const Thrust1: Resource = preload("res://entities/attacks/thrust1.tscn")
const Thrust2: Resource = preload("res://entities/attacks/thrust2.tscn")

const Dash: Resource = preload("res://entities/attacks/dash.tscn")

const ThrowSpears: Resource = preload("res://entities/attacks/throw_spears.tscn")

const GiantSpearBomb: Resource = preload("res://entities/attacks/giant_spear_bomb.tscn")

export var dash_length: float = 100.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	skill_1_cd = 4.0
#	skill_1_cd = 1.0 # TODO
	skill_2_cd = 5.0
#	skill_2_cd = 1.0 # TODO
	skill_3_cd = 5.0
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
	Thrust
	
	A long range spear thrust in a given direction
	"""
	.skill_1()
	
	var thrust: BaseAttack
	match GameManager.rng.randi_range(0, 2):
		0:
			thrust = Thrust0.instance()
		1:
			thrust = Thrust1.instance()
		2:
			thrust = Thrust2.instance()
	
	thrust.target_group = GameManager.ENEMY_GROUP
	
	thrust.initial_position = global_position
	thrust.initial_rotation = get_global_mouse_position().angle_to_point(global_position)
	
	thrust.lifetime = 2.0
	
	thrust.damage = 2.0 * damage_multiplier
	thrust.effect = AttackEffect.PUSH
	thrust.data = global_position
	
	line.add_attack(thrust)

func skill_2() -> void:
	"""
	Dash
	
	Quickly jump towards a given position
	"""
	.skill_2()
	
	var dash: BaseAttack = Dash.instance()
	var dash1: BaseAttack = Dash.instance()
	
	dash.initial_position = global_position
	dash1.initial_position = global_position
	dash1.initial_position.y += 5.0
	dash1.initial_position.x += GameManager.rng.randf_range(-5.0, 5.0)
	
	dash.lifetime = 2.0
	dash1.lifetime = 2.0
	
	line.add_attack(dash)
	line.add_attack(dash1)
	
	var dash_pos: Vector2 = get_global_mouse_position()
	if global_position.distance_to(dash_pos) > dash_length:
#		dash_pos = global_position + ((dash_pos - global_position).normalized() * dash_length) 
		dash_pos = (dash_pos - global_position).normalized() * dash_length
	else:
		dash_pos = dash_pos - global_position
	
	# TODO just teleport for now
	global_position += dash_pos
#	for unit in line.units: # TODO maybe apply dash to all units?
#		unit.global_position += dash_pos
	position_to = global_position + dash_pos

func skill_3() -> void:
	"""
	Throw spears
	
	Materialize 3 spears and throw them in a given direction
	"""
	.skill_3()
	
	var spears: Array = [
		ThrowSpears.instance(),
		ThrowSpears.instance(),
		ThrowSpears.instance()
	]
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	
	for spear in spears:
		spear.target_group = GameManager.ENEMY_GROUP
		spear.initial_position = global_position
		spear.initial_rotation = mouse_pos.angle_to_point(global_position)
		spear.lifetime = 4.0
	
		spear.damage = 2.0 * damage_multiplier
		spear.effect = AttackEffect.PUSH
		spear.data = global_position
		
		spear.target_position = mouse_pos
		
		line.add_attack(spear)
		yield(get_tree().create_timer(0.25), "timeout")

func skill_4() -> void:
	"""
	Giant spear bomb
	
	Call down a giant spear on a given position
	"""
	.skill_4()
	
	var spear_bomb: BaseAttack = GiantSpearBomb.instance()
	spear_bomb.target_group = GameManager.ENEMY_GROUP
	spear_bomb.initial_position = get_global_mouse_position()
	
	spear_bomb.lifetime = 2.0
	spear_bomb.damage = 30.0 * damage_multiplier
	spear_bomb.effect = AttackEffect.NONE
	
	line.add_attack(spear_bomb)
