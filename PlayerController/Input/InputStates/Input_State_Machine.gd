extends Node2D

class_name InputStateMachine

var states : Dictionary[String,InputState] = {}

@onready var current_state : InputState = %InputStateSelection
@onready var grid_controller : GridController = %TilesGround
@onready var battle_manager : BattleManager = %BattleManager
@onready var drawing_2D : Drawing2D = %Drawing2D
@onready var cursor : Cursor = %Cursor

var mouse_pos : Vector2
var pause_mode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state in get_children():
		if state is InputState:
			states[state.name] = state
			state.state_machine = self
			state.grid_controller = grid_controller
			state.battle_manager = battle_manager
			state.drawing_2D = drawing_2D

	EventBus.char_path_finished.connect(character_finished_path)


func _process(_delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	#MousePosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	#MousePosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	
	cursor.global_position = grid_controller.hovered_grid_pos*GridProps2D.cellSize
			
	current_state.Update(_delta)


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


func character_finished_path(unit:Character):
	if current_state.has_method("handle_path_finished"):
		current_state.handle_path_finished(unit)


func pause_toggle():
	get_tree().paused = !get_tree().paused


func quit_game():
	get_tree().quit()
