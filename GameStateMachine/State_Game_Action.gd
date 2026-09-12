extends StateGame

class_name StateGameAction

var action_ : ActionCommand

func _enter_state(battle_scene_script:SceneBattle):
	super(battle_scene_script)
	print("ENTERING ACTION STATE!")


func _init(action:ActionCommand) -> void:
	action_ = action 
	if action_:
		action_.action_finished.connect(end_state)


func end_state():
	print("EXITING ACTION STATE!")
	on_state_finished.emit(StateGameSelect.new())


func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	if _event.is_action_pressed("Select"):
		action_.action_input_confirm()
	elif _event.is_action_released("Cancel"):
		action_.end_action()
		return StateGameSelect.new()

	return null
