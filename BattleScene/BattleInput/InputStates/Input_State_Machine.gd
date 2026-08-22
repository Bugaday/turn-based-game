extends Node2D

class_name InputStateMachine


var states : Dictionary[String,InputState] = {}
@export var current_state : InputState
@export var scene_data : SceneData

var mouse_pos : Vector2


func _setup():
	for state:InputState in get_children():
			if state is InputState:
				states[state.name] = state
				state.state_machine = self
				state.scene_data = scene_data
				state.change_state.connect(state_change)


func _process(_delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	#cursor.global_position = grid_controller.hovered_grid_pos*GridProps2D.cellSize
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


func enable_input():
	state_change(%InputStateSelect.name)


func pause_toggle():
	get_tree().paused = !get_tree().paused


func quit_game():
	get_tree().quit()
