extends StateHover

class_name StateHoverNone

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing):
	print("Entering no hover state!")

func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		on_hover_state_finished.emit(StateHoverGrid.new())
