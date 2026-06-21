extends InputState

class_name InputStateSelection

func _enter_state():
	print("Entering ",%InputStateSelection.name, " Input Mode")


func _exit_state():
	print("Exiting ",%InputStateSelection.name, " Input Mode")


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Escape"):
		state_machine.quit_game()
	elif _event.is_action_pressed("Select"):
		if check_for_player_character():
			select_character()
			state_machine.state_change(%InputStateUnitSelected.name)


func check_for_player_character() -> bool:
	var cell = grid_controller.get_cell_data(state_machine.mouse_pos)
	if cell.UnitOccupying:
		if cell.UnitOccupying.faction == 0:
			return true
	return false

func select_character():
	var cell = grid_controller.get_cell_data(state_machine.mouse_pos)
	battle_manager.select_character(cell.UnitOccupying)
	grid_controller.cellSelected = cell
	drawing_2D.on_select_unit(cell)
