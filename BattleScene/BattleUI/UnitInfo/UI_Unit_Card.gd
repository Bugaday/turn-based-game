extends Control

class_name UIUnitCard

@export var label_dict : Dictionary[String,String] = {}
@export var image_dict : Dictionary[String,Texture] = {}


func update_all_values(unit:Character):
	label_dict["Health"] = str(unit.health_.current_health)
	label_dict["Action Points"] = str(unit.action_points_current)
	image_dict["Portrait"] = unit.base_stats.sprite
