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
		var cell_data : GridCellData = battle_data.grid[posi]
		if cell_data.UnitOccupying:
			var unit : Character = cell_data.UnitOccupying
			if unit.faction == "Player":
				battle_data.selected_character = unit
				battle_data.active_character = unit
		elif battle_data.selected_character:
			var selected_unit : Character = battle_data.selected_character
			if selected_unit:
				var new_move = ActionCommandMove.new(selected_unit,get_global_mouse_position())
				call_action.emit(new_move)
				#selected_unit.start_action("Move",battle_data.battle_script)
				state_machine.state_change(%InputStateSelectMovePoint.name)
