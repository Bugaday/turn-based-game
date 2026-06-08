extends RefCounted

class_name BattleManager

var teamTurn : int = 0;
var teamCount : int = 2;
var charScene : PackedScene
var teams : Array[Team]
var unit_selected : Character

signal CharsInitialised(chars : Array[Character])
signal CharacterMoved(char : Character,pos : Vector2i)


func _setup():
	charScene = preload("res://Characters/Character.tscn")
	var team0 : Team = load("res://Characters/Teams/team_0.tres")
	var team1 : Team = load("res://Characters/Teams/team_1.tres")
	teams.append(team0)
	teams.append(team1)


func _initChars():
	var characters : Array[Character] = []
	for i in teams.size():
		for j in teams[i].teamMembers.size():
			var newChar : Character = charScene.instantiate()
			newChar.stats = teams[i].teamMembers[j]
			characters.append(newChar)
	CharsInitialised.emit(characters)

func on_cell_selected():
	pass

func on_unit_selected(unit : Character):
	unit_selected = unit


func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
