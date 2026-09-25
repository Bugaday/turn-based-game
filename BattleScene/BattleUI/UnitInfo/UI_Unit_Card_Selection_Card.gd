class_name UIUnitCardSelectionCard
extends UIUnitCard

var character_linked : Character
@export var values : Dictionary[String,Label]
@export var unit_name : Label
@export var char_texture : TextureRect
@export var health_progress : ProgressBar
@export var resource_progress : ProgressBar
@export var char_stat : CharacterData

signal on_mini_portrait_pressed(unit:Character,card:UIUnitCardSelectionCard)


func _pressed() -> void:
	on_mini_portrait_pressed.emit(character_linked,self)
	
	
func update_single_value(value_name:String,value):
	if values.has(value_name):
		values[value_name].text = str(value)
		if value_name == "Health":
			health_progress.value = value


func update_values(value_dictionary:Dictionary[String,Variant]):
	for entry in value_dictionary:
		if values[entry]:
			values[entry].text = str(value_dictionary[entry])
		if entry == "Health":
			health_progress.value = value_dictionary[entry]
