extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _setInfo(stats : UnitStats, pos : Vector2):
	$Panel/TextureRect.texture = stats.sprite
	position = pos
	%StatsLabel.text = "Name: " + stats.unit_name + "\n\n" + "Health: " + str(stats.health) + "\n" + "Stamina: " + str(stats.stamina) + "\n" + "Strength: " + str(stats.strength) + "\n" + "Attack Power: " + str(stats.attackPower)
