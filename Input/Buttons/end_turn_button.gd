extends Button

func _pressed() -> void:
	EventBus.turn_finished.emit()
