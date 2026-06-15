extends InputState

class_name InputStateMovingCharacter

func _enter_state():
	print("Entering MOVING CHARACTER Input Mode")
	state_machine.move_character()
	pass
	
func _exit_state():
	print("Exiting MOVING CHARACTER Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Pause"):
		state_machine.pause_toggle()
