extends ActionCommand

class_name ActionCommandAttack

var potential_target_list : Array[Character]
var cells_in_range : Array[Vector2i]
var target : Character

func _init() -> void:
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
	if calc_action_point_cost() > source_char.action_points_current:
		end_action()
		return
	target.apply_health_change(-10)
	var offset : Vector2 = Vector2(0.0,-32.0)
	battle_scene_.ui_battle.spawn_floating_text("10",target.position+offset,battle_scene_)
	super()
	UIBattle.game_log.log("[color=#ff4444]" + source_char.character_name  + " attacked " + target.character_name + "[/color]")
	end_action()


func update_action():
	var mouseCellPos = GridService.world_to_grid(battle_scene_.get_global_mouse_position())
	var cellData : GridCellData = GridService.get_cell_data_at_pos(mouseCellPos,battle_scene_.battle_data.grid)
	if potential_target_list.has(cellData.UnitOccupying):
		#print("This is a target cell!")
		target = cellData.UnitOccupying
		action_location_ = target.position
		show_action_point_cost_text(Color.RED)
	else:
		battle_scene_.drawing_battle.draw_text.clear_text()


func end_action():
	print("Ending attack action")
	potential_target_list.clear()
	cells_in_range.clear()
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list)
	super()


func get_viable_targets():
	print("Running Get Viable Targets")
	potential_target_list.clear()
	cells_in_range.clear()
	
	#Check for cells in range
	var char_cell : Vector2i = GridService.world_to_grid(source_char.position)
	for i:int in range(-1,2):
		for j:int in range(-1,2):
			var cell : Vector2i = Vector2i(char_cell.x+i,char_cell.y+j)
			#If this cell is the one the character is standing on, or it is out of bounds
			#then go straight to the next iteration of the loop, as this is an invalid cell
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
					print("Found a unit to attack!")
	battle_scene_.drawing_battle.draw_action.draw_items(cells_in_range,potential_target_list)
