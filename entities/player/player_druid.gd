extends BasePlayerUnit

const GraspingRoots0: Resource = preload("res://entities/attacks/grasping_roots0.tscn")
const GraspingRoots1: Resource = preload("res://entities/attacks/grasping_roots1.tscn")
const GraspingRoots2: Resource = preload("res://entities/attacks/grasping_roots2.tscn")

const MiracleGrowth: Resource = preload("res://entities/attacks/miracle_growth.tscn")

const BlasphemousTotem: Resource = preload("res://entities/attacks/blasphemous_totem.tscn")

const HiddenPath: Resource = preload("res://entities/attacks/hidden_path.tscn")

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
	
	var roots: BaseAttack
	match GameManager.rng.randi_range(0, 2):
		0:
			roots = GraspingRoots0.instance()
		1:
			roots = GraspingRoots1.instance()
		2:
			roots = GraspingRoots2.instance()

	roots.target_group = GameManager.ENEMY_GROUP

	roots.initial_position = get_global_mouse_position()
	
	roots.lifetime = 3.0

	roots.damage = 3.0 * damage_multiplier
	roots.effect = AttackEffect.ROOT
	roots.data = 2.0

	line.add_attack(roots)

# TODO mostly unimplemented
func skill_2() -> void:
	"""
	Miracle growth
	
	Create a tree at a given position that can block an attack
	Trees will explode when destroyed or after a medium duration
	"""
	.skill_2()
	
	var growth: BaseAttack = MiracleGrowth.instance()
	growth.initial_position = get_global_mouse_position()

	growth.lifetime = 10.0

	line.add_attack(growth)

func skill_3() -> void:
	"""
	Blasphemous Totem
	
	Create a totem at a given position that heals the party for a duration
	"""
	.skill_3()
	
	var totem: BaseAttack = BlasphemousTotem.instance()
	totem.initial_position = get_global_mouse_position()

	totem.lifetime = 10.0

	line.add_attack(totem)

func skill_4() -> void:
	"""
	Hidden path
	
	Quickly travel to a location, creating Miracle Growth trees along the way
	and reducing cooldowns
	"""
	.skill_4()

	# TODO teleport for now
	global_position = get_global_mouse_position()
	
	var up_path: BaseAttack = HiddenPath.instance()
	var down_path: BaseAttack = HiddenPath.instance()
	var left_path: BaseAttack = HiddenPath.instance()
	var right_path: BaseAttack = HiddenPath.instance()

	var paths: Array = [
		up_path,
		down_path,
		left_path,
		right_path
	]

	up_path.initial_position = global_position
	up_path.initial_position.y -= 40.0

	down_path.initial_position = global_position
	down_path.initial_position.y += 40.0

	left_path.initial_position = global_position
	left_path.initial_position.x -= 40.0

	right_path.initial_position = global_position
	right_path.initial_position.x += 40.0

	for i in paths:
		i.lifetime = 5.0
		line.add_attack(i)
	
	for unit in line.units:
		unit.skill_1_counter *= 1.2
		unit.skill_2_counter *= 1.2
		unit.skill_3_counter *= 1.2
		unit.skill_4_counter *= 1.2
	
