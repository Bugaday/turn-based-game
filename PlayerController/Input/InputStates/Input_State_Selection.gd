extends InputState

class_name InputStateSelection

func _enter_state():
	print("Entering SELECTION Input Mode")
	pass
	
func _exit_state():
	print("Exiting SELECTION Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	print("Handling input for SELECTION Input Mode")
	pass
