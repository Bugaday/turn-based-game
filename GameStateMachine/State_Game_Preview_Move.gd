extends StateGame

class_name StateGamePreviewMove

var mousePos : Vector2
var path : PackedVector2Array

func _init(path:PackedVector2Array) -> void:
	path = path

func handle_input(_event : InputEvent,battle_scene_script:SceneBattle)->StateGame:
	if _event.is_action_pressed("Select"):
		var gridPos : Vector2i = GridService.world_to_grid(mousePos)
		var cell : GridCellData = GridService.get_cell_data_at_pos(gridPos,battle_scene_script.battle_data.grid)
		print("Cell is: ",cell.UnitOccupying)
		if cell.UnitOccupying and cell.UnitOccupying.faction == "Player":
			battle_scene_script.drawing_battle.draw_move_path.clear_path()
			battle_scene_script.select_character(cell.UnitOccupying)
			return StateGameSelect.new()
		elif battle_scene_script.battle_data.selected_character:
			var unit : Character = battle_scene_script.battle_data.selected_character
			var path = battle_scene_script.path_finder.get_path_from_char(unit.position,mousePos,true)
			var move_action : ActionCommand = ActionCommandMove.new(battle_scene_script.battle_data.selected_character,path,battle_scene_script)
			battle_scene_script.command_processor.add_action(move_action)
			var busy_state : StateGameBusy =  StateGameBusy.new()
			move_action.action_finished.connect(busy_state.end_busy,CONNECT_ONE_SHOT)
			return busy_state
	elif _event.is_action_pressed("Cancel"):
		battle_scene_script.drawing_battle.draw_move_path.clear_path()
		return StateGameSelect.new()

	return null


func Update(delta: float,game:SceneBattle) -> void:
	var unit : Character = game.battle_data.selected_character
	mousePos = game.get_global_mouse_position()
	path = game.path_finder.get_path_from_char(unit.position,mousePos,true)
	game.drawing_battle.draw_move_path._drawPath(game.battle_data.selected_character.position,path)
