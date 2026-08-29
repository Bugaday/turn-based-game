extends RefCounted

class_name StateGame

signal state_finished(action:ActionCommand)


func _enter_state(battle_scene_script:SceneBattle):
	Debug.log("Entering new state")
	pass


func handle_input(_event : InputEvent,battle_scene_script:SceneBattle)->StateGame:
	return null


func Update(delta: float,battle_scene_script:SceneBattle) -> void:
	pass


func _exit_state(battle_scene_script:SceneBattle):
	#Debug.log("Exiting %s Input Mode"%state_machine.current_state.name,Color.RED)
	pass
