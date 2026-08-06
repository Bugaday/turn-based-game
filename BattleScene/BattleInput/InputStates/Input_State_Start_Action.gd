extends InputState

class_name InputStateStartAction

func _enter_state():
	super()


func _exit_state():
	super()
	pass


func handle_input(_event : InputEvent):
	if _event.is_action_pressed("Escape") or _event.is_action_pressed("RightClick"):
		EventBus.cancel_path.emit()
		change_state.emit("InputStateSelect")
	elif _event.is_action_pressed("Select"):
		change_state.emit(%InputStateInputDisabled.name)
