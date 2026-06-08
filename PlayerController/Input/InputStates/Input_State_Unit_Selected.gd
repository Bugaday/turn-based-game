extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering UNIT SELECTION Input mode!")
	
func _exit_state():
	print("Exiting UNIT SELECTION Input mode!")

func _on_cell_clicked(cell : GridCellData):
	if !cell.UnitOccupying:
		print("Cell not occupied in UNIT SELECTION mode")
		input_state_machine.state_change("MOVEPREVIEW")
	else:
		print("Cell occupied in UNIT SELECTION mode")
		
func _on_rightclick():
	pass
	
func _on_mouse_hover():
	pass
