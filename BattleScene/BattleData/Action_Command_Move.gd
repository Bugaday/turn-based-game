extends ActionCommand

class_name ActionCommandMove


var move_path : PackedVector2Array
var destination_cell : Vector2i
var mousePos : Vector2
var choosing_destination : bool = true


func _init(src_char:Character,battle_scene:SceneBattle,data:ActionData,b_is_player:bool,destination:Vector2i=Vector2.ZERO) -> void:
	super(src_char,battle_scene,data,b_is_player)
	action_name = "Move"
	action_verb = "Moving"
	if b_is_player_:
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	else:
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,GridService.grid_to_world(destination),true)
		destination_cell = GridService.world_to_grid(move_path.get(move_path.size()-1))


func start_action():
	#Super currently just prints the action name
	super()
	#Why is this here? For AI?
	if move_path.is_empty():
		end_action()
		return
	if not b_is_player_:
		execute_action()


func action_input_confirm():
	if choosing_destination:
		super()


func execute_action():
	battle_scene_.drawing_battle.draw_box.visible = false
	choosing_destination = false
	move_to_next_waypoint()


func update_action():
	mousePos = battle_scene_.get_global_mouse_position()
	if choosing_destination:
		#At this point, and as the player we just have a path from the char to the mouse position.
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	#Need to check if we have a path here?
	action_location = move_path[move_path.size()-1]
	battle_scene_.drawing_battle.draw_move_path._drawPath(source_char.position,move_path,source_char.action_points_current/max(calc_action_point_cost(),1))
	
	#This is the super version that uses calc_action_point_cost
	visualise_action_point_cost(Color.WHITE,move_path.size())


func end_action():
	UIBattle.game_log.log(source_char.character_name  + " [color=#4aff44]moved[/color] to " + str(destination_cell))
	battle_scene_.drawing_battle.draw_move_path.clear_path()
	battle_scene_.drawing_battle.draw_box.position = source_char.position
	battle_scene_.drawing_battle.draw_box.visible = true
	super()


#Progress to next waypoint
func move_to_next_waypoint():
	source_char.char_last_cell_pos = move_path[0]
	#Remove the first waypoint that we're standing on, pushing the next into index 0 to move towards
	move_path.remove_at(0)
	#If there are no more waypoints, finish the path
	if move_path.is_empty() or calc_single_cell_cost(source_char.position,move_path[0]) > source_char.action_points_current:
		end_action()
		return
	
	var tween : Tween = source_char.create_tween()
	var move_distance : float = source_char.position.distance_to(move_path[0])
	var move_time = move_distance / GridProps2D.gridSizeX * source_char.base_stats.move_speed
	tween.tween_property(source_char,"global_position",move_path[0],move_time)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	source_char.action_points_current -= calc_single_cell_cost(source_char.char_last_cell_pos,source_char.position)
	battle_scene_.path_finder.set_cell_free_from_vector2(source_char.char_last_cell_pos)
	var last_cell : Vector2i = GridService.world_to_grid(source_char.char_last_cell_pos)
	battle_scene_.battle_data.grid[last_cell].UnitOccupying = null
	battle_scene_.path_finder.set_blocked_cell_from_vector2(source_char.position)
	var current_cell : Vector2i = GridService.world_to_grid(source_char.position)
	battle_scene_.battle_data.grid[current_cell].UnitOccupying = source_char
	DebugVis.update_blocked_positions()
	move_to_next_waypoint()


func calc_single_cell_cost(start:Vector2,end:Vector2)->float:
	#This is cost per unit (distance of 1) moved based on move_speed of Character
	var dist : float = start.distance_to(end)
	var dist_in_cell_size : float = dist / float(GridProps2D.cellSize.x)
	var cost : int = dist_in_cell_size * source_char.base_stats.move_speed
	return cost


func calc_action_point_cost()->int:
	var total_cost : int
	if move_path.size() > 0:
		for point:int in move_path.size()-1:
			var cost = calc_single_cell_cost(move_path[point],move_path[point+1])
			total_cost += cost
		return total_cost
	return 10
	
	#if move_path.size() >= 1:
		#var dist : float = source_char.position.distance_to(move_path[0])
		#var dist_in_cell_size : float = dist / float(GridProps2D.cellSize.x)
		#var cost : int = dist_in_cell_size * source_char.base_stats.move_speed
		#print("Dist: ", dist, " Dist Cell: ", dist_in_cell_size, " Cost: ", cost)
		#return cost
	#return 99
