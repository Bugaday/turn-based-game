extends InputState

class_name InputStateMovePreview

func _enter_state():
	print("Entering MOVE PREVIEW Input Mode")
	pass
	
func _exit_state():
	print("Exiting MOVE PREVIEW Input Mode")
	pass
	
func handle_input(_event : InputEvent):
	print("Handling input for MOVE PREVIEW Input Mode")
	pass
