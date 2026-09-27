class_name UIUnitCardSelectionGroup
extends UIUnitCard

@export var ui_unit_mini_cards_player : Control
@export var ui_unit_mini_cards_enemy : Control

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
