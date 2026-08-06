extends InputState

class_name InputStateSelect

func _enter_state():
	super()


func _exit_state():
	super()


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Escape"):
		state_machine.quit_game()
	elif _event.is_action_pressed("Select"):
		var posi : Vector2i = GridService.world_to_grid(get_global_mouse_position())
		var cell_data : GridCellData = state_machine._grid[posi]
		if cell_data.UnitOccupying:
			var unit : Character = cell_data.UnitOccupying
			if unit.faction == "Player":
				battle_data.selected_character = unit
				battle_data.active_character = unit
				#battle_data.battle_blackboard.set_value("selected_character",unit)
				#battle_data.battle_blackboard.set_value("active_character",unit)
				#battle_blackboard.battle_script.select_character(unit)
		elif battle_data.selected_character:
			var selected_unit : Character = battle_data.selected_character
			if selected_unit:
				selected_unit.actions[0]._action_started()
				state_machine.state_change(%InputStateSelectMovePoint.name)
