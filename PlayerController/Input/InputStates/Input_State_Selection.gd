extends InputState

class_name InputStateSelection

func _enter_state():
	pass
	
func _exit_state():
	pass
	
func _select(pos:Vector2):
	input_state_machine.check_for_selection.emit(pos)

func _on_cell_clicked(cell : GridCellData):
	if cell.UnitOccupying:
		input_state_machine.state_change("UNITSELECTED")
		
func _on_rightclick():
	pass
	
func _on_mouse_hover():
	pass
