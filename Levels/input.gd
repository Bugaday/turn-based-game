extends Node

signal ActivateMove
signal Select

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		print("Mouse is selecting!")
		Select.emit()
