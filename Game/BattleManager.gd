extends RefCounted

class_name BattleManager

var _gm : GameManager

var teamTurn : int = 0;
var teamCount : int = 2;
var charScene : PackedScene
var characters : Array[Character] = []

var teams : Array[Team]


func _setup(gm:GameManager):
	_gm = gm

	charScene = preload("res://Characters/Character.tscn")

	var team0 : Team = load("res://Characters/Teams/team_0.tres")
	var team1 : Team = load("res://Characters/Teams/team_1.tres")
	teams.append(team0)
	teams.append(team1)


func _initChars():

	for i in teams.size():
		for j in teams[i].teamMembers.size():
			var newChar = charScene.instantiate()
			newChar.stats = teams[i].teamMembers[j]
			characters.append(newChar)
			_gm.add_child(newChar)
			newChar.global_position = GetRandomGridCell(i)


func GetRandomGridCell(team : int) -> Vector2:
	var x = randi_range(team*GridProps2D.gridXCount/2,(GridProps2D.gridXCount-1)/2+team*GridProps2D.gridXCount/2)
	var y = randi_range(0,GridProps2D.gridYCount-1)

	return Vector2(x*GridProps2D.cellSize.x+GridProps2D.cellSize.x/2,y*GridProps2D.cellSize.y+GridProps2D.cellSize.y/2)


func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
