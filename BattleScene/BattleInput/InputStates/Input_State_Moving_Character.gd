extends InputState

class_name InputStateMovingCharacter

func _enter_state():
	super()
	EventBus.char_start_move.emit()
	pass


func _exit_state():
	super()
	battle_manager.free_all_characters()
	print_rich()
	pass


func Update(delta: float) -> void:
	drawing_2D.draw_move_path()


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Pause"):
		state_machine.pause_toggle()


func move_character():
	battle_manager.move_character()


func handle_path_finished(unit:Character):
	battle_manager.select_character(unit.position)
	state_machine.state_change(%InputStateSelection.name)
