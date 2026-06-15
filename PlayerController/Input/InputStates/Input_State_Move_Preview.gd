extends InputState

class_name InputStateMovePreview

func _enter_state():
	print("Entering MOVE PREVIEW Input Mode")
	pass
	
func _exit_state():
	print("Exiting MOVE PREVIEW Input Mode")
	state_machine.exit_move_preview()
	pass
	
func handle_input(_event : InputEvent):
	if _event is InputEventMouseMotion:
		state_machine.show_move_preview()
		print("Input is mouse")
	elif _event.is_action_pressed("Select"):
		if state_machine.check_movable_location():
			state_machine.state_change("MOVINGCHARACTER")
	elif _event.is_action_pressed("Escape") or _event.is_action_pressed("RightClick"):
		state_machine.state_change("UNITSELECTED")
		#print(_event, " input for MOVE PREVIEW Input Mode")
	pass
