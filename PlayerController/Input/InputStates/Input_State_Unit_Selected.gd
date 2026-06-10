extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering UNIT SELECTED Input Mode")
	pass
	
func _exit_state():
	print("Exiting UNIT SELECTED Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	print("Handling input for UNIT SELECTED Input Mode")
	pass
