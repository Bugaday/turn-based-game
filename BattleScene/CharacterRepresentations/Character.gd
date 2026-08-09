extends Node2D

class_name Character

signal start_move_on_path()
signal action_started()
signal action_finished()
signal path_finished()

var char_last_cell_pos : Vector2
var faction : String
var move_path : PackedVector2Array

@export var char_sprite : Sprite2D

@export var stats : CharacterData
@export var actions : Array[Action]
var action_dictionary : Dictionary[String,Action]
var current_action : Action
@export var ai_actions_list : AIActionsData
@export var class_list : Array[AIAction]


func _ready() -> void:
	if stats:
		_setStats()
	for action in actions:
		action_dictionary.set(action.action_name,action)

		
func start_action(action_name:String,target:Object):
	action_dictionary[action_name]._action_started(target)
 

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
	var move_distance : float = position.distance_to(move_path[0])
	var move_time = move_distance / GridProps2D.gridSizeX * stats.move_speed
	tween.tween_property(self,"global_position",move_path[0],move_time)
	tween.finished.connect(section_complete)


#A section of path has just completed
func section_complete():
	EventBus.char_path_section_completed.emit()
	move_to_next_waypoint()


#The whole path is now complete	
func path_complete():
	path_finished.emit(self)
	action_finished.emit()


func _setStats() -> void:
	for action in stats.extra_actions:
		actions.append(action)
	char_sprite.texture = stats.sprite
