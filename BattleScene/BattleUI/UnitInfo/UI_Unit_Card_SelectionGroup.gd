class_name UIUnitCardSelectionGroup
extends Control

@export var ui_unit_mini_cards_group_player : Control
@export var ui_unit_mini_cards_group_enemy : Control
var mini_card_scene : PackedScene = load("res://UI_Mini_Unit_Card.tscn")

func update_mini_cards(faction_units:Dictionary[String,Array],battle_scene:SceneBattle):
	for faction in faction_units.keys():
		if faction == "Player":
			var player_team : Array = faction_units["Player"]
			populate_mini_cards_group(player_team,ui_unit_mini_cards_group_player,battle_scene)
		else:
			var enemy_team : Array = faction_units[faction]
			populate_mini_cards_group(enemy_team,ui_unit_mini_cards_group_enemy,battle_scene)


func populate_mini_cards_group(team:Array,group:Control,battle_scene:SceneBattle):
	if team.size() != group.get_child_count():
		if group.get_child_count() > 0:
			for card in group.get_children():
				card.queue_free()
		for member:Character in team:
			var new_mini_card : UIUnitCardSelectionCard = mini_card_scene.instantiate()
			group.add_child(new_mini_card)
			new_mini_card.character_linked = member
			new_mini_card.on_mini_portrait_pressed.connect(battle_scene.select_character)


func mini_card_select(card_selected:UIUnitCardSelectionCard):
	var current_stylebox : StyleBox = card_selected.get_theme_stylebox("normal")
	var new_borderless_stylebox : StyleBoxFlat = current_stylebox.duplicate()
	new_borderless_stylebox.set_border_width_all(0.0)
	for card : UIUnitCardSelectionCard in ui_unit_mini_cards_group_player.get_children():
		if current_stylebox is StyleBoxFlat:
			card.add_theme_stylebox_override("normal",new_borderless_stylebox)
	var new_stylebox : StyleBox = current_stylebox.duplicate()
	new_stylebox.set_border_width_all(4.0)
	card_selected.add_theme_stylebox_override("normal",new_stylebox)
