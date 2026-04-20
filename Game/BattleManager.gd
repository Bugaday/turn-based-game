extends Node

class_name BattleManager

var teamTurn : int = 0;
var teamCount : int = 2;
@export var charParent : Node;
var characters : Array[Character];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characters = charParent.get_children() as Array[Character]# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
