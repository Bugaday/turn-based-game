extends Control

class_name UIUnitCard

@export var unit_card_portrait : TextureRect
@export var unit_card_name : Label
@export var stats_current_box : VBoxContainer
@export var theme_label_stats : Theme
@export var style_label_stats : StyleBoxFlat
@export var label_name : Label
#@export var label_health : Label
#@export var label_action_points : Label

var label_dict : Dictionary[String,Label] = {}

func _ready() -> void:
	if unit_card_portrait == null or unit_card_portrait == null:
		push_error("Portrait or Name not initialised!!")
	add_label("Health")
	add_label("Action Points")


func add_label(label_text:String)->Label:
	if label_dict.has(label_text):
		return
	var new_label : Label = Label.new()
	new_label.theme = theme_label_stats
	new_label.add_theme_stylebox_override("normal",style_label_stats)
	stats_current_box.add_child(new_label)
	label_dict.set(label_text,new_label)
	new_label.text = label_text
	return new_label


func _update_info(value_name:String,value):
	if label_dict.has(value_name):
		label_dict[value_name].text = value_name + " : " + str(value)
	else:
		push_error("No label value found!")


func _setInfo(unit : Character):
	unit_card_name.text = unit.stats.unit_name
	unit_card_portrait.texture = unit.stats.sprite
	label_dict["Health"].text = str(unit.health_.current_health)
	label_dict["Action Points"].text = str(unit.action_points_current)
