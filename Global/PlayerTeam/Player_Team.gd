extends Node

var team_members : Array[Character]

func _ready() -> void:
	if team_members.is_empty():
		add_default_members()
	
func add_default_members():
	var unit : Character = Character.new()
	unit.faction = "Player"
	team_members.append(unit)
