extends Control

class_name UIUnitCard

@export var label_name : Label
@export var label_health : Label
@export var label_action_points : Label
@export var image_portrait : TextureRect

var stylebox_panel_player : StyleBoxFlat = load("res://stylebox_panel_player.tres")
var stylebox_panel_enemy : StyleBoxFlat = load("res://stylebox_panel_enemy.tres")


func update_all_values(unit:Character):
	label_name.text = str(unit.base_stats.unit_name)
	label_health.text = str(unit.health_current)
	label_action_points.text = str(unit.action_points_current)
	image_portrait.texture = unit.base_stats.sprite
