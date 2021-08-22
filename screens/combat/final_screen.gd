extends CombatScreen

var kill_count: int = 0
var expected_kill_count: int = 3

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$Units/EnemyKnight.connect("tree_exited", self, "_on_kill")
	$Units/EnemyKnight2.connect("tree_exited", self, "_on_kill")
	$Units/EnemyCyclops.connect("tree_exited", self, "_on_kill")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_kill() -> void:
	kill_count += 1
	if kill_count == expected_kill_count:
		get_tree().change_scene("res://screens/end_screen.tscn")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


