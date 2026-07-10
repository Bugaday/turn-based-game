extends AIAction

class_name ActionMoveToEnemy

func _execute_action(unit:Character):
	print("Action moving to enemy! by ",unit.name," - ",unit.stats.unit_name)
	EventBus.action_finished.emit()


func _get_score(unit:Character) -> float:
	print("Scoring Action moving to enemy! by ",unit.name," - ",unit.stats.unit_name)
	return 0.2
