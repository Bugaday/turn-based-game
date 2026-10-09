extends StateHover

class_name StateHoverMiniCard

var unit_hovered : Character

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	if(unit_hovered):
		drawing.cursor.visible = true
		drawing.cursor.position = GridService.snap_pos_to_grid(unit_hovered.position)
	else:
		push_error("No unit passed from mini card to hover state!")
	print("Entering Mini Card Hover!")


func _exit_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	drawing.cursor.visible = false
