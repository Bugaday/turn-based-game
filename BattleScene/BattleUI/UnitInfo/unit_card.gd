extends Control

class_name UIUnitCard

@onready var unit_card_portrait : TextureRect = %UnitCardPortrait
@onready var unit_card_name : Label = %UnitCardName
	
func _setInfo(stats : CharacterData, pos : Vector2 = Vector2(1480.0,440.0)):
	unit_card_portrait.texture = stats.sprite
	position = pos
	unit_card_name.text = "Name: " + stats.unit_name + "\n\n" + "Health: " + str(stats.health) + "\n" + "Stamina: " + str(stats.stamina) + "\n" + "Strength: " + str(stats.strength) + "\n" + "Attack Power: " + str(stats.attackPower)
