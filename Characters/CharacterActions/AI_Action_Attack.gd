extends AIAction

class_name ActionAttack

func _execute_action(unit:Character):
	print("Action Attack! by ",unit.name," - ",unit.stats.unit_name)
	action_finished.emit()


func _get_score(unit:Character) -> float:
	print("Scoring Action Attack! by ",unit.name," - ",unit.stats.unit_name)
	return 0.5
