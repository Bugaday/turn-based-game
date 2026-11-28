@abstract
extends Resource

class_name AIDecision

var considerations : Array[float]
var normalised_considerations : Array[float]

@abstract func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand

func get_score(unit:Character,battle_scene:SceneBattle) -> float:
	get_considerations(unit,battle_scene)
	if considerations.size() <= 0:
		return 0.0
	normalise_considerations()
	var score : float = 1.0
	for con in considerations:
		score *= con
	return score

func get_considerations(unit:Character,battle_scene:SceneBattle):
	#Runs the functions needed to get info
	#Don't need to update these then every time any character does an action? Like moving or attacking
	considerations.clear()


func normalise_considerations():
	pass

func get_action_points_required(_unit:Character,battle_scene:SceneBattle)->int:
	return get_action(_unit,battle_scene).calc_action_point_cost()
