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
			battle_manager.select_character(state_machine.mouse_pos)
		elif battle_manager.character_selected:
			state_machine.state_change(%InputStateMovePreview.name)


func check_for_player_character() -> bool:
	var cell = grid_controller.get_cell_data(state_machine.mouse_pos)
	if cell.UnitOccupying:
		if PlayerTeam.team_members.has(cell.UnitOccupying.get_instance_id()):
			return true
	return false
	
