extends ActionCommand

class_name ActionCommandAttack

var game_battle : SceneBattle
var potential_target_list : Array[Character]
var cells_in_range : Array[Vector2i]
var target : Character


func start_action():
	super()
	get_viable_targets()
	
	
func action_input_confirm():
	var mouseCellPos = GridService.world_to_grid(battle_scene_.get_global_mouse_position())
	var cellData : GridCellData = GridService.get_cell_data_at_pos(mouseCellPos,battle_scene_.battle_data.grid)
	if potential_target_list.has(cellData.UnitOccupying):
		target = cellData.UnitOccupying
		execute_action()


func execute_action():
	target.health_.apply_health_change(-10)


func update_action():
	pass


func end_action():
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
			if cell == char_cell or !GridService.is_cell_inside_grid(cell):
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
	print(potential_target_list)
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list)
