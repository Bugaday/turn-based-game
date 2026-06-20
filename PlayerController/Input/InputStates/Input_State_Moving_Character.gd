extends InputState

class_name InputStateMovingCharacter

func _enter_state():
	print("Entering ",%InputStateMovingCharacter.name, " Input Mode")
	move_character()
	pass
	
func _exit_state():
	print("Exiting ",%InputStateMovingCharacter.name, " Input Mode")
	pass

func Update(delta: float) -> void:
	drawing_2D.draw_move_path()
	
func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Pause"):
		state_machine.pause_toggle()

func move_character():
	battle_manager.move_character()
	#drawing_2D.SelectionBox.position = grid_controller.local_to_map(dest)*GridProps2D.cellSize

func handle_path_finished(unit:Character):
	grid_controller.set_cell_data(unit)
	state_machine.state_change(%InputStateSelection.name)
