extends Node2D

class_name StateMachineHover

var current_hover_state : StateHover
@export var scene_battle : SceneBattle
@export var drawing : Drawing

func _ready() -> void:
	change_state(StateHoverNone.new())


func _process(_delta: float) -> void:
	if current_hover_state:
		current_hover_state.Update(_delta,scene_battle,drawing)


func change_state(newStateHover : StateHover):
	#Check if state name exists
	if current_hover_state:
		current_hover_state._exit_state(scene_battle,drawing)
	current_hover_state = newStateHover
	newStateHover.on_hover_state_finished.connect(change_state,CONNECT_ONE_SHOT)
	current_hover_state._enter_state(scene_battle,drawing)
