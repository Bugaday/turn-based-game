extends Control

class_name UIUnitCard

@export var ui_unit_card_main : UIUnitCardMain
@export var ui_unit_hover_card : UIUnitCardMain
@export var ui_unit_mini_cards_group : UIUnitCardSelectionGroup
@export var label_dict : Dictionary[String,String] = {}
@export var image_dict : Dictionary[String,Texture]


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


func update_mini_cards(faction_units:Dictionary[String,Array]):
	for faction in faction_units.keys():
		if faction == "Player":
			var player_team : Array = faction_units["Player"]
			populate_mini_cards_group(player_team,ui_unit_mini_cards_player)
		else:
			var enemy_team : Array = faction_units[faction]
			populate_mini_cards_group(enemy_team,ui_unit_mini_cards_enemy)

					
func populate_mini_cards_group(team:Array,group:Control):
	if team.size() != group.get_child_count():
		var mini_card_scene : PackedScene = load("res://UI_Mini_Unit_Card.tscn")
		if group.get_child_count() > 0:
			for card in group.get_children():
				card.queue_free()
		for member:Character in team:
			var new_mini_card : UIUnitCardSelectionCard = mini_card_scene.instantiate()
			group.add_child(new_mini_card)
			new_mini_card.character_linked = member
			member.on_stat_changed.connect(new_mini_card.update_single_value)
			new_mini_card.health_progress.max_value = member.base_stats.health
			new_mini_card.resource_progress.max_value = member.base_stats.action_points_max
			new_mini_card.update_values(member.get_stats_dictionary())
			new_mini_card.char_texture.texture = member.base_stats.sprite


func mini_card_select(card_selected:UIUnitCardSelectionCard):
	var current_stylebox : StyleBox = card_selected.get_theme_stylebox("normal")
	var new_borderless_stylebox : StyleBoxFlat = current_stylebox.duplicate()
	new_borderless_stylebox.set_border_width_all(0.0)
	for card : UIUnitCardSelectionCard in ui_unit_mini_cards_player.get_children():
		if current_stylebox is StyleBoxFlat:
			card.add_theme_stylebox_override("normal",new_borderless_stylebox)
	var new_stylebox : StyleBox = current_stylebox.duplicate()
	new_stylebox.set_border_width_all(4.0)
	card_selected.add_theme_stylebox_override("normal",new_stylebox)
