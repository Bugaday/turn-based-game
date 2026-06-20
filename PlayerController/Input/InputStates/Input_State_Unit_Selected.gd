extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering ",%InputStateUnitSelected.name, " Input Mode")
	select_character()


func _exit_state():
	print("Exiting ",%InputStateUnitSelected.name, " Input Mode")


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Select"):
		if not grid_controller.cell_hovered.UnitOccupying:
			state_machine.state_change(%InputStateMovePreview.name)
	elif _event.is_action_pressed("Escape"):
		state_machine.quit_game()
		
func select_character():
	var cell = grid_controller.get_cell_data(state_machine.mouse_pos)
	battle_manager.select_character(cell.UnitOccupying)
	grid_controller.cellSelected = cell
	drawing_2D.on_select_unit(cell)

func cell_selected(cell:GridCellData):
	if cell.UnitOccupying:
		if cell.UnitOccupying.faction == 0:
			state_machine.select_character()
	else:
		state_machine.state_change(%InputStateMovePreview.name)
