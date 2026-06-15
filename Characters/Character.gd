extends Node2D

class_name Character

var currentCellPos : Vector2i
var currentHealth : int
var faction : int
var move_path : PackedVector2Array

signal path_finished()

@export var stats : UnitStats;

func _ready() -> void:
	if stats:
		_setStats(stats)

func start_move(path:PackedVector2Array):
	move_path = path
	if move_path.size() <= 0:
		return

	move_to_next_waypoint()

	
func move_to_next_waypoint():
	
	if move_path.is_empty():
		pass
	
	move_path.remove_at(0)
	
	if move_path.size() <= 0:
		path_finished.emit()
		return

	var tween : Tween = create_tween()
	tween.tween_property(self,"global_position",move_path[0],1.0)
	tween.finished.connect(move_complete)
	
func move_complete():
	if move_path.size() <= 0:
		return
	move_to_next_waypoint()	
	
func path_complete():
	path_finished

func _setStats(statData: Resource) -> void:
	stats = statData;
	%CharSprite2D.texture = stats.sprite
	currentHealth = stats.health
	#print(stats.health, " : ", currentHealth, " : ", stats.stamina)
