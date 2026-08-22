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
		var cell_data : GridCellData = scene_data.grid[posi]
		if cell_data.UnitOccupying:
			var unit : Character = cell_data.UnitOccupying
			if unit.faction == "Player":
				scene_data.selected_character = unit
				scene_data.active_character = unit
		elif scene_data.selected_character:
			var selected_unit : Character = scene_data.selected_character
			if selected_unit:
				state_machine.state_change(%InputStateChooseMoveLocation.name)
