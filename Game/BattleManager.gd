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
			newChar.position = GetRandomGridCell()
		
func GetGridIDAtPos(pos : Vector2) -> int:
	return 0
		
func GetRandomGridCell() -> Vector2:
		var x = randi_range(0,GridProps2D.gridXCount-1)
		var y = randi_range(0,GridProps2D.gridYCount-1)
		return Vector2(x*16,y*16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
