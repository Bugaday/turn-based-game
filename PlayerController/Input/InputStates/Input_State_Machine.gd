extends Node2D

class_name InputStateMachine

@export var states : Dictionary[String,InputState] = {}

@onready var current_state : InputState = states["SELECTION"]
@onready var grid_controller : GridController = %TilesGround
@onready var battle_manager : BattleManager = %BattleManager
@onready var drawing_2D : Drawing2D = %Drawing2D
@onready var cursor : Cursor = %Cursor

var mouse_pos : Vector2
var hovered_grid_pos : Vector2i
var hovered_grid_pos_last : Vector2i

signal mouse_grid_pos_changed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var keys : Array[String] = states.keys()
	for key in keys:
		states[key].state_machine = self

func _process(_delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	#MousePosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	#MousePosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	
	hovered_grid_pos = grid_controller.local_to_map(mouse_pos)*GridProps2D.cellSize
	grid_controller.mouse_grid_pos = grid_controller.local_to_map(mouse_pos)
	
	if hovered_grid_pos != hovered_grid_pos_last:
		mouse_grid_pos_changed.emit(hovered_grid_pos)
		hovered_grid_pos_last = hovered_grid_pos
		
	cursor.global_position = hovered_grid_pos
	
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

func check_for_character() -> bool:
	var cell = grid_controller.get_cell_data(mouse_pos)
	if cell.UnitOccupying:
		select_character(cell)
		return true
	return false
		
func show_move_preview():
	var path : PackedVector2Array = grid_controller.get_preview_path()
	drawing_2D.draw_path(path)

func exit_move_preview():
	drawing_2D.clear_path()
	
func move_character():
	var dest : Vector2 = mouse_pos
	battle_manager.character_selected.global_position = grid_controller.local_to_map(dest)*GridProps2D.cellSize+GridProps2D.cellSize/2
	drawing_2D.SelectionBox.position = grid_controller.local_to_map(dest)*GridProps2D.cellSize
		
func select_character(cell : GridCellData):
	battle_manager.select_character(cell.UnitOccupying)
	grid_controller.cellSelected = cell
	drawing_2D.on_select_unit(cell)
		
func check_unit_selection_options():
	var cell = grid_controller.get_cell_data(mouse_pos)
	if cell.UnitOccupying:
		select_character(cell)
	else:
		state_change("MOVEMENTPREVIEW")
	
func quit_game():
	get_tree().quit()
