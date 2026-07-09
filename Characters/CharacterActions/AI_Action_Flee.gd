extends AIAction

class_name ActionFlee

func _execute_action(unit:Character):
	print("Action Flee! by ",unit.name," - ",unit.stats.unit_name)
	action_finished.emit()


func _get_score(unit:Character) -> float:
	print("Scoring Action Flee! by ",unit.name," - ",unit.stats.unit_name)
	return 0
