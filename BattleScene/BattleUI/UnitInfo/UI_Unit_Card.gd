extends Control

class_name UIUnitCard

@export var label_dict : Dictionary[String,Label] = {}
@export var image_dict : Dictionary[String,TextureRect] = {}

var stylebox_panel_player : StyleBoxFlat = load("res://stylebox_panel_player.tres")
var stylebox_panel_enemy : StyleBoxFlat = load("res://stylebox_panel_enemy.tres")


func update_all_values(unit:Character):
	label_dict["Health"].text = str(unit.health_.current_health)
	label_dict["Action Points"].text = str(unit.action_points_current)
	image_dict["Portrait"].texture = unit.base_stats.sprite
