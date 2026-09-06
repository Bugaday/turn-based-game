extends ActionCommand

class_name ActionCommandAttack

var game_battle : SceneBattle
var potential_target_list : Array[Character]
var cells_in_range : Array[Vector2i]


func start_action():
	super()
	z_index = 99
	get_viable_targets()
	


func execute_action():
	super()


func update_action():
	pass


func end_action():
	super()


func get_viable_targets():
	potential_target_list.clear()
	cells_in_range.clear()
	var char_cell : Vector2i = GridService.world_to_grid(source_char.position)
	for i:int in range(-1,1):
		for j:int in range(-1,1):
			cells_in_range.append(Vector2(i,j))
			var cell_to_check : GridCellData = GridService.get_cell_data_at_pos(char_cell+Vector2i(i,j),battle_scene_.battle_data.grid)
			if not cell_to_check:
				continue
			var unit : Character = cell_to_check.UnitOccupying
			if unit:
				if unit.faction != source_char.faction:
					potential_target_list.append(unit)
	print(potential_target_list)
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list )
