extends RefCounted

class_name StateHover

var mouse_grid_pos : Vector2

signal on_hover_state_change(new_state:StateHover)


func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	pass


func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	pass


func _exit_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	pass
