extends StateGame

class_name StateGameSelect

func handle_input(_event : InputEvent,battle_scene_script:SceneBattle)->StateGame:
	if _event.is_action_pressed("Select"):
		var mousePos : Vector2 = battle_scene_script.get_global_mouse_position()
		var gridPos : Vector2i = GridService.world_to_grid(mousePos)
		var cell : GridCellData = GridService.get_cell_data_at_pos(gridPos,battle_scene_script.battle_data.grid)
		print("Cell is: ",cell.UnitOccupying)
		if cell.UnitOccupying and cell.UnitOccupying.faction == "Player":
			battle_scene_script.select_character(cell.UnitOccupying)
		elif battle_scene_script.battle_data.selected_character:
			var unit : Character = battle_scene_script.battle_data.selected_character
			var path : PackedVector2Array = battle_scene_script.path_finder.get_path_from_char(unit.position,mousePos,true)
			return StateGamePreviewMove.new(path)

	return null
