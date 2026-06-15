extends InputState

class_name InputStateUnitSelected

func _enter_state():
	print("Entering UNIT SELECTED Input Mode")
	state_machine.select_character()


func _exit_state():
	print("Exiting UNIT SELECTED Input Mode")


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Select"):
		cell_selected(state_machine.check_unit_selection_options())
	elif _event.is_action_pressed("Escape"):
		state_machine.quit_game()


func cell_selected(cell:GridCellData):
	if cell.UnitOccupying:
		if cell.UnitOccupying.faction == 0:
			state_machine.select_character()
	else:
		state_machine.state_change("MOVEMENTPREVIEW")
