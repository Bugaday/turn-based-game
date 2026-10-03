extends Control

class_name UIUnitCardControl

@export var ui_unit_card_main : UIUnitCardMain
@export var ui_unit_hover_card : UIUnitCardHover
@export var ui_unit_mini_cards_group : UIUnitCardMiniControl


func add_new_character(unit:Character):
	ui_unit_mini_cards_group.add_card(unit)


func update_selected_character(unit:Character):
	ui_unit_card_main.update_all_values(unit)


func activate_unit_hover_card(unit:Character):
	ui_unit_hover_card.visible = true
	if unit.faction == "Player":
		#ui_unit_hover_card.theme = ui_unit_hover_card.player_panel_theme
		ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.stylebox_panel_player)
	else:
		#ui_unit_hover_card.theme = ui_unit_hover_card.enemy_panel_theme
		ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.stylebox_panel_enemy)
	ui_unit_hover_card.update_all_values(unit)


func deactivate_unit_hover_card():
	ui_unit_hover_card.visible = false
