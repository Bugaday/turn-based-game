extends ActionCommand

class_name ActionCommandMove

var move_path : PackedVector2Array

func _init(src:Character,tar:PackedVector2Array) -> void:
	super(src,tar)
	#scene_data.drawing.draw_move_line(current_char,target)


func start_action():
	move_path = target as PackedVector2Array
	if move_path.is_empty():
		action_finished.emit()
	start_finished.emit()


func execute_action():
	super()
	move_to_next_waypoint()


func update_action():
	pass


func end_action():
	#source_char.moveTargets.remove_at(1)
	action_finished.emit()
	



#Progress to next waypoint
func move_to_next_waypoint():
	source_char.char_last_cell_pos = move_path[0]
	#Remove the first waypoint that we're standing on, pushing the next into index 0 to move towards
	move_path.remove_at(0)

	#If there are no more waypoints, finish the path
	if move_path.is_empty():
		path_complete()
		return
	
	var tween : Tween = source_char.create_tween()
	var move_distance : float = source_char.position.distance_to(move_path[0])
	var move_time = move_distance / GridProps2D.gridSizeX * source_char.stats.move_speed
	tween.tween_property(source_char,"global_position",move_path[0],move_time)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	EventBus.char_path_section_completed.emit()
	move_to_next_waypoint()


#The whole path is now complete	
func path_complete():
	#path_finished.emit(self)
	action_finished.emit()
