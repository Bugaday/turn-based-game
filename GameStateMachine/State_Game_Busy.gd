extends StateGame

class_name StateGameBusy

func _enter_state(battle_scene_script:SceneBattle):
	battle_scene_script.drawing_battle.draw_box.visible = false
	battle_scene_script.drawing_battle.cursor.visible = false
	
func _exit_state(battle_scene_script:SceneBattle):
	battle_scene_script.drawing_battle.cursor.visible = true
	battle_scene_script.drawing_battle.draw_box.position = battle_scene_script.battle_data.selected_character.position
	battle_scene_script.drawing_battle.draw_box.visible = true

func end_busy():
	state_finished.emit(StateGameSelect.new())
