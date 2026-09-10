extends RefCounted

class_name StateGame

signal on_state_finished(new_state:StateGame)

func _enter_state(_battle_scene_script:SceneBattle):
	#Debug.log("Entering new state")
	pass


func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	return null


func Update(_delta: float,_battle_scene_script:SceneBattle) -> void:
	pass


func _exit_state(_battle_scene_script:SceneBattle):
	#Debug.log("Exiting %s Input Mode"%state_machine.current_state.name,Color.RED)
	pass
