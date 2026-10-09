extends Button

class_name EndTurnButton

func _ready() -> void:
	button_up.connect(on_button_up)
	#EventBus.ai_turn_started.connect(disable_button)
	#EventBus.ai_turn_finished.connect(enable_button)
	pass


func enable_button():
	disabled = false


func disable_button():
	#disabled = true
	pass


func on_button_up() -> void:
	#EventBus.trigger_turn_finished.emit()
	print("End Turn Button pressed")
