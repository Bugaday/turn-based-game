extends InputState

class_name InputStateMovePreview



func _enter_state():
	print("Entering MOVE PREVIEW Input Mode")
	input_state_machine.StartMovePreview.emit()
	
func _exit_state():
	print("Exiting MOVE PREVIEW Input Mode")

func _on_cell_clicked(cell : GridCellData):
	print("Running cell clicked on MOVE PREVIEW")
	
func _on_rightclick():
	input_state_machine.state_change("UNITSELECTED")
	
func _on_mouse_hover():
	pass
