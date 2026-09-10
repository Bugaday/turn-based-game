extends StateGame

class_name StateGameSelect

func handle_input(_event : InputEvent,battle_scene_script:SceneBattle)->StateGame:
	if _event.is_action_released("Select"):
		var mousePos : Vector2 = battle_scene_script.get_global_mouse_position()
		var gridPos : Vector2i = GridService.world_to_grid(mousePos)
		var cell : GridCellData = GridService.get_cell_data_at_pos(gridPos,battle_scene_script.battle_data.grid)
		print("Cell is: ",cell.UnitOccupying)
		if cell.UnitOccupying and cell.UnitOccupying.faction == "Player":
			battle_scene_script.select_character(cell.UnitOccupying)
		elif battle_scene_script.battle_data.selected_character:
			var unit : Character = battle_scene_script.battle_data.selected_character
			var move_action : ActionData = unit.action_list[unit.ACTION.MOVE]
			var command : ActionCommand = move_action.create_command(unit,battle_scene_script,move_action,true)
			battle_scene_script.command_processor.add_action(command)

	return null
