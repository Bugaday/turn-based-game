extends InputState

class_name InputStateSelection

func _enter_state():
	print("Entering SELECTION Input Mode")


func _exit_state():
	print("Exiting SELECTION Input Mode")


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Escape"):
		state_machine.quit_game()
	elif _event.is_action_pressed("Select"):
		if state_machine.check_for_player_character():
			state_machine.state_change("UNITSELECTED")
