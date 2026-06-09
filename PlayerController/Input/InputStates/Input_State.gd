extends Node

class_name InputState

var input_state_machine : InputStateMachine
var grid_controller : GridController

func _enter_state():
	pass
	
func _exit_state():
	pass

func _select(pos:Vector2):
	pass

func _on_cell_clicked(cell : GridCellData):
	pass
	
func _on_rightclick():
	pass
	
func _on_mouse_hover():
	pass
