extends InputState

class_name InputStateMovingCharacter

func _enter_state():
	print("Entering MOVING CHARACTER Input Mode")
	pass
	
func _exit_state():
	print("Exiting MOVING CHARACTER Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	#if _event.is_action_pressed("Select"):
		#state_machine.move_character()
	pass
