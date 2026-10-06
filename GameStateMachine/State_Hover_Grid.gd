extends StateHover

class_name StateHoverGrid

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	print("Entering Grid Hover state!")
	

func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	super(_delta,battle_scene,drawing,ui_battle)
	drawing.cursor.position = GridService.snap_pos_to_grid(battle_scene.get_global_mouse_position())
	pass
