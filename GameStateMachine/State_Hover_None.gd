extends StateHover

class_name StateHoverNone

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	print("Entering no hover state!")

func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		StateMachineHover.change_state_hover(StateMachineHover.HoverStateGrid)
