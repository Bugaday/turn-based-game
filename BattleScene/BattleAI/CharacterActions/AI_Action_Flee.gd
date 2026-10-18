extends AIAction

class_name AIActionFlee

func _execute_action(unit:Character,battle_scene:SceneBattle):
	super(unit,battle_scene)


func _get_score(unit:Character,battle_scene:SceneBattle) -> float:
	super(unit,battle_scene)
	return 0
