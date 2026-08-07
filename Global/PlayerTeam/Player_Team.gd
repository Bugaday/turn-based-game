extends Node

var team_members : Array[Character]

func _init() -> void:
	if team_members.is_empty():
		add_default_members()


func add_default_members():
	var default_stats : CharacterData = load("res://BattleScene/BattleData/CharacterData/Knight.tres")
	var unit : Character = Character.new()
	unit.stats = default_stats
	unit.faction = "Player"
	team_members.append(unit)
