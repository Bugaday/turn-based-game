extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering ",%InputStateUnitSelected.name, " Input Mode")


func _exit_state():
	print("Exiting ",%InputStateUnitSelected.name, " Input Mode")


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Select"):
		if not grid_controller.cell_hovered.UnitOccupying:
			state_machine.state_change(%InputStateMovePreview.name)
	elif _event.is_action_pressed("Escape"):
		state_machine.quit_game()


func cell_selected(cell:GridCellData):
	if cell.UnitOccupying:
		if cell.UnitOccupying.faction == 0:
			state_machine.select_character()
	else:
		state_machine.state_change(%InputStateMovePreview.name)
