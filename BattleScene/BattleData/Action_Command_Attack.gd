extends ActionCommand

class_name ActionCommandAttack

var game_battle : SceneBattle
var potential_target_list : Array[Character]


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


func _draw() -> void:
	for i in potential_target_list:
		draw_circle(i.position,24,Color.RED,true,4.0,true)


func get_viable_targets():
	var char_cell : Vector2i = GridService.world_to_grid(source_char.position)
	for i:int in range(-1,1):
		for j:int in range(-1,1):
			var cell_to_check : GridCellData = GridService.get_cell_data_at_pos(char_cell+Vector2i(i,j),battle_scene_.battle_data.grid)
			if not cell_to_check:
				continue
			var unit : Character = cell_to_check.UnitOccupying
			if unit:
				if unit.faction != source_char.faction:
					potential_target_list.append(unit)
	print(potential_target_list)
	queue_redraw()
