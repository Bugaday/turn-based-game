class_name UIBattle
extends Node

@export var action_button_controller : ActionButtonController
@export var ui_unit_cards : UIUnitCardControl
var text_floating : FloatingText


func on_character_selected(unit:Character,battle_scene:SceneBattle):
	ui_unit_cards.update_selected_character(unit)
	action_button_controller.update_button_set(unit,battle_scene)
	#ui_unit_cards._update_all_labels(unit)


func on_character_hovered(unit:Character,bIsHovered:bool):
	ui_unit_cards.activate_unit_hover_card(unit)
	var mini_card : UIUnitCardMini = ui_unit_cards.ui_unit_mini_cards_group.get_card_by_character(unit)
	mini_card.card_hovered()
	
 
func on_character_unhovered():
	ui_unit_cards.deactivate_unit_hover_card()
	ui_unit_cards.ui_unit_mini_cards_group.unhover_all_mini_cards()
	#var mini_card : UIUnitCardMini = ui_unit_cards.ui_unit_mini_cards_group.get_card_by_character(unit)
	#mini_card.card_unhovered()


func on_character_spawned(unit:Character):
	ui_unit_cards.add_new_character(unit)


func spawn_floating_text(text,pos:Vector2,parent:Node2D):
	var string_ : String = str(text)
	text_floating = FloatingText.new(string_,pos)
	parent.add_child(text_floating)


func trigger_new_turn():
	#battle_manager.faction_turn_finished()
	#set_turn_text()
	pass


func set_turn_text():
	#if battle_manager.current_faction_index == 0:
		#turn_text.text = "Player Turn"
	#else:
		#turn_text.text = "Enemy Turn"
	pass
