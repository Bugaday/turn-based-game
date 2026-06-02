extends Node

class_name GameManager

@onready var TilesGroundObj : TileMapLayer = %TilesGround

var input_controller : InputController
var grid_controller : GridController
var ui_controller : UIController
var battle_manager : BattleManager
var drawing_2D : Drawing2D

var characters : Array[Character]
var charNum : int = 4;

var DrawLines : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

	grid_controller = GridController.new()
	ui_controller = UIController.new()
	battle_manager = BattleManager.new()
	drawing_2D = Drawing2D.new()
	input_controller = InputController.new()

	#input_controller.MouseGridPosChanged.connect(_onHoveredCell)
	input_controller.Select.connect(grid_controller.on_cell_clicked)

	%Camera2D.InputCtrl = input_controller
	grid_controller.setup_grid(%TilesGround)
	input_controller._setup(TilesGroundObj)
	battle_manager._setup(self)
	drawing_2D._setup(input_controller)
	
	battle_manager._initChars()
	
	for i in battle_manager.characters:
		var CharGridPos = Vector2i(i.global_position) / GridProps2D.cellSize
		#Grid2D[CharGridPos].UnitOccupying = i
		#Grid2D[CharGridPos].isOccupied = true
	
	add_child(drawing_2D)
	add_child(input_controller)


func spawn_characters():
	for i in battle_manager.characters:
		pass
	
