extends Node2D

class_name InputState

var state_machine : InputStateMachine
var grid_controller : GridController
var battle_manager : BattleManager
var drawing_2D : Drawing2D

func _enter_state():
	pass
	
func _exit_state():
	pass
	
func handle_input(_event : InputEvent):
	pass
	
func Update(delta: float) -> void:
	pass
	
func Draw() -> void:
	pass
