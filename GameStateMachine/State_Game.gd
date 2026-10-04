extends RefCounted

class_name StateGame

signal on_state_finished(new_state:StateGame)

func _enter_state(_battle_scene_script:SceneBattle):
	pass


func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	return null


func Update(_delta: float,battle_scene:SceneBattle) -> void:
	pass


func _exit_state(_battle_scene_script:SceneBattle):
	pass
