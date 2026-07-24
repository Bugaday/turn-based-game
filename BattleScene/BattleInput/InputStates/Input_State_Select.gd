extends InputState

class_name InputStateSelect

func _enter_state():
	super()


func _exit_state():
	super()


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Escape"):
		state_machine.quit_game()
	elif _event.is_action_pressed("Select"):
		EventBus.try_select_character.emit(get_global_mouse_position())
