extends Control
	
func _setInfo(stats : CharacterData, pos : Vector2):
	$Panel/TextureRect.texture = stats.sprite
	position = pos
	%StatsLabel.text = "Name: " + stats.unit_name + "\n\n" + "Health: " + str(stats.health) + "\n" + "Stamina: " + str(stats.stamina) + "\n" + "Strength: " + str(stats.strength) + "\n" + "Attack Power: " + str(stats.attackPower)
