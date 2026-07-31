extends AIAction

class_name AIActionAttack


func _execute_action(unit:Character):
	super(unit)
	EventBus.action_finished.emit()


func _get_score(unit:Character) -> float:
	super(unit)
	return 0.2
