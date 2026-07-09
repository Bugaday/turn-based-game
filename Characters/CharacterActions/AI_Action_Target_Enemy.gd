extends AIAction

class_name ActionTargetEnemy

func _execute_action(unit:Character):
	print("Action target enemy! by ",unit.name," - ",unit.stats.unit_name)
	action_finished.emit()


func _get_score(unit:Character) -> float:
	print("Scoring Action target enemy! by ",unit.name," - ",unit.stats.unit_name)
	return 0
