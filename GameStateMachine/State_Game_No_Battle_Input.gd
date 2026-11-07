class_name StateGameNoBattleInput

extends StateGame

func _init() -> void:
	state_name = "No Input Turn State"

func _enter_state(_battle_scene_script:SceneBattle):
	pass
	
func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	return null
	
func _exit_state(_battle_scene_script:SceneBattle):
	pass
