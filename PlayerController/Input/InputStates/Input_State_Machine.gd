extends Node2D

class_name InputStateMachine

@export var states : Dictionary[String,InputState] = {}

@onready var current_state : InputState = states["SELECTION"]
@onready var grid_controller : GridController = %TilesGround

var mouse_pos : Vector2
var hovered_grid_pos : Vector2i
var hovered_grid_pos_last : Vector2i

signal check_for_selection(pos:Vector2)
signal mouse_grid_pos_changed()
signal StartMovePreview()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	#MousePosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	#MousePosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	
	hovered_grid_pos = grid_controller.local_to_map(mouse_pos)
	
	if hovered_grid_pos != hovered_grid_pos_last:
		mouse_grid_pos_changed.emit(hovered_grid_pos)
		hovered_grid_pos_last = hovered_grid_pos
	
	#MoveVert = Input.get_axis("MoveUp","MoveDown")
	#MoveHorz = Input.get_axis("MoveLeft","MoveRight")
	
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func state_change(newState : String):
	#Check if state name exists
	print("Changing to state: ", newState)
	if not states.has(newState):
		print("No Input state with the name: ", newState, " found!")
		return
	current_state._exit_state()
	current_state = states[newState]
	current_state._enter_state()
	
func route_select(pos:Vector2):
	pass

func route_cell_clicked(cell : GridCellData):
	current_state._on_cell_clicked(cell)
	
func route_rightclick():
	current_state._on_rightclick()
