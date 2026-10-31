extends ActionCommand

class_name ActionCommandAttack

var potential_target_list : Array[Character]
var cells_in_range : Array[Vector2i]
var target : Character

func _init(src_char:Character,battle_scene:SceneBattle,_data:ActionData,b_is_player:bool) -> void:
	super(src_char,battle_scene,_data,b_is_player)
	action_name = "Attack"
	action_verb = "Attacking"


func start_action():
	super()
	if b_is_player_:
		get_viable_targets()
	else:
		execute_action()
	
	
func action_input_confirm():
	var mouseCellPos = GridService.world_to_grid(battle_scene_.get_global_mouse_position())
	var cellData : GridCellData = GridService.get_cell_data_at_pos(mouseCellPos,battle_scene_.battle_data.grid)
	if potential_target_list.has(cellData.UnitOccupying):
		target = cellData.UnitOccupying
		execute_action()


func execute_action():
	target.apply_health_change(-10)
	var offset : Vector2 = Vector2(0.0,-32.0)
	battle_scene_.ui_battle.spawn_floating_text("10",target.position+offset,battle_scene_)
	super()
	UIBattle.game_log.log("[color=#ff4444]" + source_char.character_name  + " attacked " + target.character_name + "[/color]")
	#battle_scene_.ui_battle.game_log.log(source_char.character_name  + " [color=#ff4444]attacked[/color] " + target.character_name)
	end_action()


func update_action():
	pass


func end_action():
	print("Ending attack action")
	super()
	potential_target_list.clear()
	cells_in_range.clear()
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list)


func get_viable_targets():
	potential_target_list.clear()
	cells_in_range.clear()
	
	#Check for cells in range
	var char_cell : Vector2i = GridService.world_to_grid(source_char.position)
	for i:int in range(-1,2):
		for j:int in range(-1,2):
			var cell : Vector2i = Vector2i(char_cell.x+i,char_cell.y+j)
			if cell == char_cell or !battle_scene_.battle_data.grid.has(cell):
				continue
			cells_in_range.append(Vector2(cell))
			
			#Check for Enemies
			var cell_to_check : GridCellData = GridService.get_cell_data_at_pos(char_cell+Vector2i(i,j),battle_scene_.battle_data.grid)
			if not cell_to_check:
				continue
			var unit : Character = cell_to_check.UnitOccupying
			if unit:
				if unit.faction != source_char.faction:
					potential_target_list.append(unit)
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list)
