class_name UIUnitCardMiniControl
extends Control

@export var ui_unit_mini_cards_group_player : Control
@export var ui_unit_mini_cards_group_enemy : Control
var unit_selection_cards : Dictionary[Character,UIUnitCardMini] = {}
var mini_card_scene : PackedScene = load("res://BattleScene/BattleUI/UnitInfo/UI_Unit_Card_Mini.tscn")

func add_card(unit:Character,battle_scene:SceneBattle):
	var new_mini_card : UIUnitCardMini = mini_card_scene.instantiate()
	if unit.faction == "Player":
		ui_unit_mini_cards_group_player.add_child(new_mini_card)
	else:
		ui_unit_mini_cards_group_enemy.add_child(new_mini_card)
	unit_selection_cards.set(unit,new_mini_card)
	update_single_card(unit,new_mini_card)
	new_mini_card.character_linked = unit
	new_mini_card.on_card_hovered.connect(battle_scene.mini_card_hovered)
	unit.on_stat_changed.connect(new_mini_card.update_all_values)
	#new_mini_card.mini_card_button.mouse_entered.connect()


func get_card_by_character(unit:Character)->UIUnitCardMini:
	return unit_selection_cards[unit]


func update_single_card(unit:Character,card:UIUnitCardMini):
	card.update_all_values(unit)
	pass
	
	
func unhover_all_mini_cards():
	for character_key : Character in unit_selection_cards.keys():
		unit_selection_cards[character_key].card_unhovered()


#func update_mini_cards(faction_units:Dictionary[String,Array],battle_scene:SceneBattle):
	#for faction in faction_units.keys():
		#if faction == "Player":
			#var player_team : Array = faction_units["Player"]
			#populate_mini_cards_group(player_team,ui_unit_mini_cards_group_player,battle_scene)
		#else:
			#var enemy_team : Array = faction_units[faction]
			#populate_mini_cards_group(enemy_team,ui_unit_mini_cards_group_enemy,battle_scene)
#
#
#func populate_mini_cards_group(team:Array,group:Control,battle_scene:SceneBattle):
	#if team.size() != group.get_child_count():
		#if group.get_child_count() > 0:
			#for card in group.get_children():
				#card.queue_free()
		#for member:Character in team:
			#var new_mini_card : UIUnitCardMini = mini_card_scene.instantiate()
			#group.add_child(new_mini_card)
			#new_mini_card.character_linked = member
			#member.on_stat_changed.connect(new_mini_card.update_all_values)
			#new_mini_card.on_mini_portrait_pressed.connect(battle_scene.select_character)


func mini_card_select(card_selected:UIUnitCardMini):
	var current_stylebox : StyleBox = card_selected.get_theme_stylebox("normal")
	var new_borderless_stylebox : StyleBoxFlat = current_stylebox.duplicate()
	new_borderless_stylebox.set_border_width_all(0.0)
	for card : UIUnitCardMini in ui_unit_mini_cards_group_player.get_children():
		if current_stylebox is StyleBoxFlat:
			card.add_theme_stylebox_override("normal",new_borderless_stylebox)
	var new_stylebox : StyleBox = current_stylebox.duplicate()
	new_stylebox.set_border_width_all(4.0)
	card_selected.add_theme_stylebox_override("normal",new_stylebox)
