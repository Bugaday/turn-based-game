extends Control

class_name UIUnitCard

@export var unit_card_portrait : TextureRect
@export var unit_card_name : Label

func _ready() -> void:
	if unit_card_portrait == null or unit_card_portrait == null:
		push_error("Portrait or Name not initialised!!")
	
func _setInfo(stats : CharacterData, pos : Vector2 = Vector2(1480.0,440.0)):
	if not is_visible_in_tree():
		visible = true
	unit_card_portrait.texture = stats.sprite
	position = pos
	unit_card_name.text = "Name: " + stats.unit_name + "\n\n" + "Health: " + str(stats.health) + "\n" + "Stamina: " + str(stats.stamina) + "\n" + "Strength: " + str(stats.strength) + "\n" + "Attack Power: " + str(stats.attackPower)
