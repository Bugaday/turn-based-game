class_name UIUnitCardSelectionCard
extends UIUnitCard

var character_linked : Character

signal on_mini_portrait_pressed(unit:Character,card:UIUnitCardSelectionCard)


func _pressed() -> void:
	on_mini_portrait_pressed.emit(character_linked,self)
