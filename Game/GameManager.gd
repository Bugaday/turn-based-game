extends Node

class_name GameManager

var PathfinderObj : Pathfinder2D

@onready var TilesGroundObj : TileMapLayer = %TilesGround

var InputObj : InputController
var InputHoverObj : InputHover
var BattleManagerObj : BattleManager
var DrawingObj : Drawing2D

var characters : Array[Character]
var charNum : int = 4;

var Grid2D : Dictionary[Vector2i,GridCellData] = {}
var DrawLines : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Grid2D = Grid2DConstructor.CreateGrid()
	SetTiles()
	
	PathfinderObj = Pathfinder2D.new()
	BattleManagerObj = BattleManager.new()
	DrawingObj = Drawing2D.new()
	InputObj = InputController.new()
	InputHoverObj = InputHover.new()
	InputObj.MouseGridPosChanged.connect(InputHoverObj._hover)
	InputObj.MouseGridPosChanged.connect(_onHoveredCell)

	%Camera2D.InputCtrl = InputObj
	InputObj._setup(TilesGroundObj)
	BattleManagerObj._setup(self)
	DrawingObj._setup(InputObj)
	
	BattleManagerObj._initChars()
	
	for i in BattleManagerObj.characters:
		var CharGridPos = Vector2i(i.global_position) / GridProps2D.cellSize
		Grid2D[CharGridPos].UnitOccupying = i
		Grid2D[CharGridPos].isOccupied = true
	
	add_child(DrawingObj)
	add_child(InputObj)
	
func _onHoveredCell(cellPos : Vector2i):
	var getCell : GridCellData = Grid2D[cellPos]
	if getCell.UnitOccupying:
		print(getCell.UnitOccupying.stats.unit_name)
		%UnitCard.visible = true
		%UnitCard._setInfo(getCell.UnitOccupying.stats,%TilesGround.map_to_local(cellPos)+Vector2(128,64))
	else:
		%UnitCard.visible = false

func SetTiles():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
		
	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.9,0.1])
	
	for i in Grid2D:
			
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]

		%TilesGround.set_cell(i,0,pickedCell)
