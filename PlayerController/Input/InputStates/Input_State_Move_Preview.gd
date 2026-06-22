extends InputState

class_name InputStateMovePreview

func _enter_state():
	print("Entering ",%InputStateMovePreview.name, " Input Mode")
	battle_manager.block_other_characters(battle_manager.character_selected)
	show_move_preview()
	pass
	
func _exit_state():
	print("Exiting ",%InputStateMovePreview.name, " Input Mode")
	battle_manager.free_all_characters()
	drawing_2D.clear_path()
	pass


func handle_input(_event : InputEvent):
	if _event is InputEventMouseMotion:
		show_move_preview()
	elif _event.is_action_pressed("Select"):
		if check_movable_location():
			state_machine.state_change(%InputStateMovingCharacter.name)
	elif _event.is_action_pressed("Escape") or _event.is_action_pressed("RightClick"):
		state_machine.state_change(%InputStateSelection.name)
	pass
	
func check_movable_location() -> bool:
	var cell : GridCellData = grid_controller.get_cell_data(state_machine.mouse_pos)
	if cell.UnitOccupying:
		return false
	return true
	
func show_move_preview():
	drawing_2D.draw_path()
