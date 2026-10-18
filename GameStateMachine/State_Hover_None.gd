extends StateHover

class_name StateHoverNone

func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		StateMachineHover.change_state_hover(StateMachineHover.HoverStateGrid)
