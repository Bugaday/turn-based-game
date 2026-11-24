extends StateHover

class_name StateHoverCharacter

func _enter_state(_battle_scene_script:SceneBattle,_drawing:Drawing,ui_battle:UIBattle):
	ui_battle.ui_unit_cards.ui_unit_hover_card.visible = true

func Update(_delta: float,_battle_scene:SceneBattle,_drawing:Drawing,_ui_battle:UIBattle) -> void:
	pass

func _exit_state(_battle_scene_script:SceneBattle,_drawing:Drawing,ui_battle:UIBattle):
	ui_battle.ui_unit_cards.ui_unit_hover_card.visible = false
	pass
