extends Control

class_name UIUnitCard

@export var ui_unit_card_main : UIUnitCardMain
@export var ui_unit_hover_card : UIUnitCardMain
@export var ui_unit_mini_cards_group : UIUnitCardSelectionGroup
@export var label_dict : Dictionary[String,String] = {}
@export var image_dict : Dictionary[String,Texture] = {}


func update_all_unit_cards(unit:Character):
	ui_unit_card_main.update_all_values(unit)
	ui_unit_hover_card.update_all_values(unit)
	ui_unit_mini_cards_group.update_all_values(unit)


func update_all_values(unit:Character):
	label_dict["Health"] = str(unit.health_.current_health)
	label_dict["Action Points"] = str(unit.action_points_current)
	image_dict["Portrait"] = unit.base_stats.sprite


func update_unit_stats(value_name:String,value):
	ui_unit_card_main._update_label(value_name,value)
	

func activate_unit_hover_card(b_isActive:bool,unit:Character):
	ui_unit_hover_card.visible = b_isActive
	if b_isActive:
		if unit.faction == "Player":
			ui_unit_hover_card.theme = ui_unit_hover_card.player_panel_theme
			ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.player_panel_stylebox)
		else:
			ui_unit_hover_card.theme = ui_unit_hover_card.enemy_panel_theme
			ui_unit_hover_card.add_theme_stylebox_override("panel",ui_unit_hover_card.enemy_panel_stylebox)
		ui_unit_hover_card._update_all_labels(unit)
