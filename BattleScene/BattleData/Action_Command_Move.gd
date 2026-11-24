extends ActionCommand

class_name ActionCommandMove

var move_path_ : PackedVector2Array
var move_speed_modifier : float = 3.0

#This is the actual destination index of the path reached ..
#.. before we run out of action points
var valid_cell_number : int = 0

var mousePos : Vector2
var choosing_destination : bool = true


func _init() -> void:
	action_name = "Move"
	action_verb = "Moving"

#When choosing an action via either the player, or AI
func on_action_activated(unit:Character):
	super(unit)
	choosing_destination = true
	if b_is_player_:
		move_path_ = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	else:
		move_path_ = battle_scene_.path_finder.get_path_from_char(source_char.position,action_location_,true)
	pass


func start_action():
	#Super currently just prints the action name
	super()
	#Why is this here? For AI?
	if move_path_.is_empty():
		end_action()
		return
	if not b_is_player_:
		execute_action()


func get_score()->float:
	var enemies_in_range : Array[Character] = battle_scene_.battle_data.ai_registry.unit_blackboards[source_char].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		var closest_enemy : Character = battle_scene_.battle_data.ai_registry.unit_blackboards[source_char].get_value("Closest_Enemy")
		var move_path : PackedVector2Array = battle_scene_.path_finder.get_path_from_char(source_char.position,closest_enemy.position,true)
		if move_path.size() > 1:
			var action_cost : int = ActionCommandMove.calc_single_cell_cost(move_path[0],move_path[1],source_char)
			if action_cost > source_char.action_points_current:
				return 0.0
			else:
				return 1.0
		else:
			return 0.0
	else:  
		return 0.0


func action_input_confirm():
	if choosing_destination:
		#Executes action
		super()


func execute_action():
	battle_scene_.drawing_battle.draw_box.visible = false
	choosing_destination = false
	move_to_next_waypoint()


func update_action():
	mousePos = battle_scene_.get_global_mouse_position()
	if choosing_destination:
		#At this point, and as the player we just have a path from the char to the mouse position.
		move_path_ = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
		calc_action_point_cost()
	#Need to check if we have a path here?
	action_location_ = move_path_[move_path_.size()-1]
	battle_scene_.drawing_battle.draw_move_path._drawPath(move_path_,valid_cell_number,source_char)

	#This is the super version that uses calc_action_point_cost
	show_action_point_cost_text()


func end_action():
	battle_scene_.drawing_battle.draw_move_path.clear_path()
	battle_scene_.drawing_battle.draw_box.position = source_char.position
	battle_scene_.drawing_battle.draw_box.visible = true
	super()


#Progress to next waypoint
func move_to_next_waypoint():
	#If there are no more waypoints, finish the path
	if move_path_.size() < 2 or calc_single_cell_cost(source_char.position,move_path_[1],source_char) > source_char.action_points_current:
		end_action()
		return
	
	var tween : Tween = source_char.create_tween()
	var move_distance : float = move_path_[0].distance_to(move_path_[1])
	var move_time = move_distance / GridProps2D.gridSizeX * source_char.base_stats.move_speed * (1.0 / move_speed_modifier)
	tween.tween_property(source_char,"global_position",move_path_[1],move_time)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	source_char.action_points_current -= calc_single_cell_cost(move_path_[0],source_char.position,source_char)
	battle_scene_.path_finder.set_cell_free_from_vector2(move_path_[0])
	var last_cell : Vector2i = GridService.world_to_grid(move_path_[0])
	battle_scene_.battle_data.grid[last_cell].UnitOccupying = null
	battle_scene_.path_finder.set_blocked_cell_from_vector2(source_char.position)
	var current_cell : Vector2i = GridService.world_to_grid(source_char.position)
	battle_scene_.battle_data.grid[current_cell].UnitOccupying = source_char
	source_char.char_last_cell_pos = move_path_[0]
	#Remove the waypoint we just came from, pushing the next into index 0 that we're standing on
	move_path_.remove_at(0)
	if move_path_.size() < 2 or calc_single_cell_cost(source_char.position,move_path_[1],source_char) > source_char.action_points_current:
		UIBattle.game_log.log(source_char.character_name  + " [color=#4aff44]moved[/color] to " + str(GridService.world_to_grid(move_path_[0])))
	DebugVis.update_blocked_positions()
	move_to_next_waypoint()


static func calc_single_cell_cost(start:Vector2,end:Vector2,unit:Character)->int:
	#This is cost per unit (distance of 1) moved based on move_speed of Character, distance for diagonals, and any other terrain modifiers
	var dist : float = start.distance_to(end)
	var dist_in_cell_size : float = dist / float(GridProps2D.cellSize.x)
	var cost : int = int(dist_in_cell_size * unit.base_stats.move_speed)
	return cost


func calc_action_point_cost()->int:
	var total_cost : int = 0
	valid_cell_number = 0

	if move_path_.size() < 2:
		return 0

	for i in range(move_path_.size() - 1):
		var dest : Vector2 = move_path_[i+1]
		total_cost += calc_single_cell_cost(move_path_[i],dest,source_char)
		if total_cost <= source_char.action_points_current:
			valid_cell_number += 1
		else:
			return total_cost
	
	return total_cost
