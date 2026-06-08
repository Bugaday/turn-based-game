extends Node

class_name GameManager

@onready var TilesGroundObj : TileMapLayer = %TilesGround
@onready var input_controller : InputController = %InputController
@onready var input_state_machine : InputStateMachine = %InputStateMachine
@onready var camera_2d : Camera2D = %Camera2D

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
	
	add_child(drawing_2D)
	add_child(grid_controller)
	
	#SETUP FUNCTIONS
	camera_2d.InputCtrl = input_controller
	grid_controller.setup_grid(TilesGroundObj)
	battle_manager._setup()
	drawing_2D._setup()

	#SIGNALS CONNECTIONS
	input_controller.MouseGridPosChanged.connect(grid_controller.get_hovered_cell)
	input_controller.Select.connect(grid_controller.on_cell_clicked)
	input_controller.RightClick.connect(input_state_machine.route_rightclick)
	input_controller.MouseGridPosChanged.connect(drawing_2D._on_Mouse_Grid_Pos_Changed)
	input_state_machine.StartMovePreview.connect(grid_controller.get_move_preview_cells)
	battle_manager.CharsInitialised.connect(grid_controller.on_chars_initialised)
	grid_controller.cell_selected.connect(drawing_2D.on_select_unit)
	grid_controller.cell_selected.connect(input_state_machine.route_cell_clicked)
	grid_controller.send_move_preview_cells.connect(drawing_2D.DrawnPath._drawPath)
	
	battle_manager._initChars()
	
