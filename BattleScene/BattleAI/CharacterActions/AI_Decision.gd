@abstract
extends Resource

class_name AIDecision

var considerations : Array[float]

@abstract func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand

@abstract func get_score(_unit:Character,battle_scene:SceneBattle) -> float

func get_action_points_required(_unit:Character,battle_scene:SceneBattle)->int:
	return get_action(_unit,battle_scene).calc_action_point_cost()
