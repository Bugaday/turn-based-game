extends InputState

class_name InputStateSelection

func _enter_state():
	super()


func _exit_state():
	super()


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
		var bb:AIBlackboard = battle_manager.ai_registry.get_unit_blackboard(cell.UnitOccupying)
		if bb.parent_blackboard == battle_manager.ai_registry.faction_blackboards.get("Player"):
			return true
	return false
	
