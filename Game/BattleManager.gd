extends RefCounted

class_name BattleManager

var _gm : GameManager

var teamTurn : int = 0;
var teamCount : int = 2;
var charScene : PackedScene
var characters : Array[Character] = []

var teams : Array[Team]

signal CharsInitialised(chars : Array[Character])
signal CharacterMoved(char : Character,pos : Vector2i)


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
			var randomGridCell : Vector2i = GetRandomGridCell(i)
			newChar.currentCellPos = randomGridCell
			var finalPos = randomGridCell * GridProps2D.cellSize + GridProps2D.cellSize/2
			newChar.position = finalPos
	CharsInitialised.emit(characters)


func GetRandomGridCell(team : int) -> Vector2i:
	var gridX = GridProps2D.gridXCount
	var gridY = GridProps2D.gridYCount
	
	var x = randi_range(team*gridX/2.0,(gridX-1.0)/2.0+team*gridX/2.0)
	var y = randi_range(0,gridY-1)
	
	return Vector2i(x,y)


func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
