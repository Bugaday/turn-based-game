extends StateHover

class_name StateHoverCharacter

func _enter_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	ui_battle.ui_unit_cards.ui_unit_hover_card.visible = true
	print("Entering character hover!")

func Update(_delta: float,battle_scene:SceneBattle,drawing:Drawing,ui_battle:UIBattle) -> void:
	pass

func _exit_state(_battle_scene_script:SceneBattle,drawing:Drawing,ui_battle:UIBattle):
	ui_battle.ui_unit_cards.ui_unit_hover_card.visible = false
	pass
