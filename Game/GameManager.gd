extends Node

class_name GameManager

var PathfinderObj : Pathfinder2D

@onready var TilesGroundObj : TileMapLayer = %TilesGround

var InputObj : InputController
var BattleManagerObj : BattleManager
var DrawingObj : Drawing2D

var characters : Array[Character]
var charNum : int = 4;

var Grid2D : Dictionary = {}
var DrawLines : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Grid2D = Grid2DConstructor.CreateGrid()
	SetTiles()
	
	PathfinderObj = Pathfinder2D.new()
	BattleManagerObj = BattleManager.new()
	DrawingObj = Drawing2D.new()
	InputObj = InputController.new()
	
	%Camera2D.InputCtrl = InputObj
	InputObj._setup(TilesGroundObj)
	BattleManagerObj._setup(self)
	DrawingObj._setup(PathfinderObj,InputObj)
	
	BattleManagerObj._initChars()
	
	add_child(DrawingObj)
	add_child(InputObj)

func SetTiles():
	for i in Grid2D:
		%TilesGround.set_cell(i,0,Vector2i(0,1))
