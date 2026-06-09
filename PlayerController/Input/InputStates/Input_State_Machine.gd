extends Node

class_name InputStateMachine

@export var states : Dictionary[String,InputState] = {}
@onready var current_state : InputState = states["SELECTION"]

var grid_controller : GridController

signal check_for_selection(pos:Vector2)
signal StartMovePreview()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var string_keys : Array[String] = states.keys()
	for state_key in string_keys:
		states[state_key].input_state_machine = self
		states[state_key].grid_controller = grid_controller
	
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
