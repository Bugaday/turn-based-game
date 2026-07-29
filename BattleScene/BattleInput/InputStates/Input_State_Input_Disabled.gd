extends InputState

class_name InputStateInputDisabled

func _enter_state():
	super()
	#EventBus.char_start_move.emit()
	pass


func _exit_state():
	super()
	pass


func Update(delta: float) -> void:
	#drawing_2D.draw_move_path()
	pass


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Pause"):
		state_machine.pause_toggle()


func move_character():
	#battle_manager.move_character()
	pass


func handle_path_finished(unit:Character):
	#battle_manager.select_character(unit.position)
	state_machine.state_change(%InputStateSelect.name)
