extends StateHover

class_name StateHoverGrid

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	drawing.cursor.visible = true


func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		var mouse_grid_pos_clamped = GridService.world_to_grid(battle_scene.get_global_mouse_position())
		var cell_data = GridService.get_cell_data_at_pos(mouse_grid_pos_clamped,battle_scene.battle_data.grid)
		drawing.cursor.position = GridService.snap_pos_to_grid(battle_scene.get_global_mouse_position())
		if cell_data.UnitOccupying:
			ui_battle.ui_unit_cards.activate_unit_hover_card(cell_data.UnitOccupying)
			cell_data.UnitOccupying
		else:
			ui_battle.ui_unit_cards.deactivate_unit_hover_card()
	else:
		StateMachineHover.change_state_hover(StateMachineHover.HoverStateNone)
			
func _exit_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	ui_battle.ui_unit_cards.deactivate_unit_hover_card()
	drawing.cursor.visible = false
