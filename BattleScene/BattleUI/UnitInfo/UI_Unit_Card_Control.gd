extends Control

class_name UIUnitCardControl

@export var ui_unit_card_main : UIUnitCardMain
@export var ui_unit_hover_card : UIUnitCardHover
@export var ui_unit_mini_cards_group : UIUnitCardSelectionGroup


func update_all_unit_cards(unit:Character):
	ui_unit_card_main.update_all_values(unit)
	ui_unit_hover_card.update_all_values(unit)
	ui_unit_mini_cards_group.update_all_values(unit)


func activate_unit_hover_card(b_isActive:bool,unit:Character):
	ui_unit_hover_card.visible = b_isActive
	if b_isActive:
		if unit.faction == "Player":
			#ui_unit_hover_card.theme = ui_unit_hover_card.player_panel_theme
			ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.stylebox_panel_player)
		else:
			#ui_unit_hover_card.theme = ui_unit_hover_card.enemy_panel_theme
			ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.stylebox_panel_enemy)
		ui_unit_hover_card.update_all_values(unit)
