extends Button

class_name EndTurnButton

signal on_turn_finished_pressed()

func _pressed() -> void:
	on_turn_finished_pressed.emit()
