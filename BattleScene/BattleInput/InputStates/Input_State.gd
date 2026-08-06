extends Node2D

class_name InputState

signal change_state(state:String)

var state_machine : InputStateMachine
var battle_data : BattleData

func _enter_state():
	Debug.log("Entering %s Input Mode"%state_machine.current_state.name)
	pass
	
func _exit_state():
	Debug.log("Exiting %s Input Mode"%state_machine.current_state.name,Color.RED)
	pass
	
func handle_input(_event : InputEvent):
	pass
	
func Update(delta: float) -> void:
	pass
	
func Draw() -> void:
	pass
