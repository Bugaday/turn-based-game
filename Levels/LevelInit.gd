extends Node

var characters : Array[Character]
var charNum : int = 4;

var Grid2D : Dictionary = {}
var DrawLines : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Grid2D = Grid2DConstructor.CreateGrid()
	SetTiles()
	DrawLines = Grid2DLines.new()
	#var new_unit : Character = load("res://Characters/Character.tscn").instantiate()
	#add_child(new_unit)
	#new_unit._setStats(load("res://Characters/Knight.tres"))
	pass

func SetTiles():
	for i in Grid2D:
		%TilesGround.set_cell(i,0,Vector2i(0,1))
