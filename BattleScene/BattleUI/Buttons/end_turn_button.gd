extends Button

class_name EndTurnButton

signal on_turn_finished_pressed()

func _ready() -> void:
	EventBus.ai_turn_started.connect(disable_button)
	EventBus.ai_turn_finished.connect(enable_button)

	
func enable_button():
	disabled = false
	
func disable_button():
	disabled = true


func _on_button_up() -> void:
	on_turn_finished_pressed.emit()
	print("Button pressed")
