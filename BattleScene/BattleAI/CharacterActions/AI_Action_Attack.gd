extends AIAction

class_name ActionAttack

func _init() -> void:
	action_name = "Attack"
	super()

func _execute_action(unit:Character):
	super(unit)
	EventBus.action_finished.emit()


func _get_score(unit:Character) -> float:
	super(unit)
	return 0.2
