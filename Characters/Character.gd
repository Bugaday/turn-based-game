extends Node2D

class_name Character

var char_last_cell_pos : Vector2
var faction : String
var move_path : PackedVector2Array

@export var stats : CharacterData
@export var ai_actions_list : AIActionsData


func _ready() -> void:
	if stats:
		_setStats(stats)


#Start the movement code
func start_move(path:PackedVector2Array):
	move_path = path
	if move_path.is_empty():
		return
	move_to_next_waypoint()


#Progress to next waypoint
func move_to_next_waypoint():
	char_last_cell_pos = move_path[0]
	#Remove the first waypoint that we're standing on, pushing the next into index 0 to move towards
	move_path.remove_at(0)

	#If there are no more waypoints, finish the path
	if move_path.is_empty():
		path_complete()
		return
	
	var tween : Tween = create_tween()
	tween.tween_property(self,"global_position",move_path[0],1.0)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	EventBus.char_path_section_completed.emit(self)
	move_to_next_waypoint()	


#The whole path is now complete	
func path_complete():
	EventBus.char_path_finished.emit(self)


func _setStats(statData: Resource) -> void:
	stats = statData;
	%CharSprite2D.texture = stats.sprite
