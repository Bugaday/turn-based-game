extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering UNIT SELECTED Input Mode")
	pass
	
func _exit_state():
	print("Exiting UNIT SELECTED Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Select"):
		state_machine.check_unit_selection_options()
	elif _event.is_action_pressed("Escape"):
		state_machine.quit_game()
