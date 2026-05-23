extends Node

class_name BattleManager

var teamTurn : int = 0;
var teamCount : int = 2;
@export var teams : Array[Team]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Char : PackedScene = load("res://Characters/Character.tscn")
	
	for i in teams.size():
		for j in teams[i].teamMembers.size():
			var newChar = Char.instantiate() as Character
			add_child(newChar)
			newChar._setStats(teams[i].teamMembers[j])
			newChar.global_position = GetRandomGridCell(i)
			var cell: Vector2i = %TilesGround.local_to_map(newChar.global_position)
			%LevelInit.Grid2D[cell].isOccupied = true
			%LevelInit.Grid2D[cell].UnitOccupying = newChar

		
func GetRandomGridCell(team : int) -> Vector2:
		var x = randi_range(team*GridProps2D.gridXCount/2,(GridProps2D.gridXCount-1)/2+team*GridProps2D.gridXCount/2)
		var y = randi_range(0,GridProps2D.gridYCount-1)

		return Vector2(x*GridProps2D.cellSize.x+GridProps2D.cellSize.x/2,y*GridProps2D.cellSize.y+GridProps2D.cellSize.y/2)

func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
