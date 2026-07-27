extends InputState

class_name InputStateDrawMovePath

func _enter_state():
	super()
	show_move_preview()
	pass
	
func _exit_state():
	super()
	pass


func handle_input(_event : InputEvent):
	if _event is InputEventMouseMotion:
		EventBus.update_draw_move_path.emit()
	#elif _event.is_action_pressed("Escape") or _event.is_action_pressed("RightClick"):
		#state_machine.state_change(%InputStateSelect.name)


func check_movable_location() -> bool:
	#var cell : GridCellData = grid_controller.get_cell_data(state_machine.mouse_pos)
	#if cell.UnitOccupying:
		#return false
	return true
	
func show_move_preview():
	#drawing_2D.draw_path(grid_controller.cellSelected.cell_pos,grid_controller.cell_hovered.cell_pos)
	pass
