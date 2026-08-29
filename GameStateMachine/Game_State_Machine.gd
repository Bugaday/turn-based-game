extends Node2D

class_name GameStateMachine

var current_state : StateGame
@export var scene_battle : SceneBattle

func _ready() -> void:
	change_state(StateGameSelect.new())

func _process(_delta: float) -> void:
	if current_state:
		current_state.Update(_delta,scene_battle)


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		var potential_new_state : StateGame = current_state.handle_input(event,scene_battle)
		if potential_new_state != null:
			change_state(potential_new_state)
	if event.is_action_pressed("Open Visual Debugger"):
		DebugVis.toggle()


func change_state(newState : StateGame):
	#Check if state name exists
	if current_state:
		current_state._exit_state(scene_battle)
	current_state = newState
	current_state.state_finished.connect(change_state,CONNECT_ONE_SHOT)
	print("Changing to state: ", newState)
	current_state._enter_state(scene_battle)
