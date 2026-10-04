extends RefCounted

class_name StateHover

signal on_hover_state_finished(new_state:StateHover)


func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing):
	pass


func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		var mouseGridPos : Vector2i = GridService.world_to_grid(battle_scene.get_global_mouse_position())
		var cell_data : GridCellData = GridService.get_cell_data_at_pos(mouseGridPos,battle_scene.battle_data.grid)
		if cell_data.UnitOccupying:
			on_hover_state_finished.emit(StateHoverCharacter.new())


func _exit_state(_battle_scene_script:SceneBattle,drawing:Drawing):
	pass
