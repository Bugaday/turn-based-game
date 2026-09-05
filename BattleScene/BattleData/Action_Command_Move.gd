extends ActionCommand

class_name ActionCommandMove

var move_path : PackedVector2Array
var mousePos : Vector2
var choosing_destination : bool = true

func _init(src_char:Character,battle_scene:SceneBattle,data:ActionData,b_is_player:bool) -> void:
	super(src_char,battle_scene,data,b_is_player)
	if b_is_player_:
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	else:
		var random_cell : Vector2i = GridService.GetRandomGridCell(battle_scene_.battle_data.grid,battle_scene_.battle_data.tilemap)
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	#scene_data.drawing.draw_move_line(current_char,target)


func start_action():
	if move_path.is_empty():
		action_finished.emit()
		return
	if not b_is_player_:
		start_finished.emit()
	elif Input.is_action_pressed("Select"):
		choosing_destination = true
		if choosing_destination:
			start_finished.emit()


func execute_action():
	super()
	choosing_destination = false
	#move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
	move_to_next_waypoint()


func update_action():
	mousePos = battle_scene_.get_global_mouse_position()
	if choosing_destination:
		move_path = battle_scene_.path_finder.get_path_from_char(source_char.position,battle_scene_.get_global_mouse_position(),true)
		battle_scene_.drawing_battle.draw_move_path._drawPath(source_char.position,move_path)
		if Input.is_action_pressed("Select"):
			battle_scene_.drawing_battle.draw_box.visible = false
			start_finished.emit()
		elif Input.is_action_pressed("Cancel"):
			end_action()


func end_action():
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
	if move_path.is_empty():
		end_action()
		return
	
	var tween : Tween = source_char.create_tween()
	var move_distance : float = source_char.position.distance_to(move_path[0])
	var move_time = move_distance / GridProps2D.gridSizeX * source_char.stats.move_speed
	tween.tween_property(source_char,"global_position",move_path[0],move_time)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	battle_scene_.path_finder.set_cell_free_from_vector2(source_char.char_last_cell_pos)
	var last_cell : Vector2i = GridService.world_to_grid(source_char.char_last_cell_pos)
	battle_scene_.battle_data.grid[last_cell].UnitOccupying = null
	battle_scene_.path_finder.set_blocked_cell_from_vector2(source_char.position)
	var current_cell : Vector2i = GridService.world_to_grid(source_char.position)
	battle_scene_.battle_data.grid[current_cell].UnitOccupying = source_char
	DebugVis.update_blocked_positions()
	move_to_next_waypoint()
