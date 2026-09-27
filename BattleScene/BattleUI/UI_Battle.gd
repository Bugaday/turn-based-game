class_name UIBattle
extends Node

@export var action_button_controller : ActionButtonController
@export var ui_unit_cards : UIUnitCardControl
var text_floating : FloatingText


func hook_char_signals(all_units:Array[Character]) -> void:
	for unit in all_units:
		#unit.character_blackboard.on_blackboard_value_set.connect(ui_unit_card._update_all_labels)
		#unit.on_stat_changed.connect(update_unit_stats)
		#unit.on_current_stats_changed.connect(spawn_floating_text)
		pass


func spawn_floating_text(text,pos:Vector2,parent:Node2D):
	var string_ : String = str(text)
	text_floating = FloatingText.new(string_,pos)
	parent.add_child(text_floating)


func on_character_selected(unit:Character,battle_scene : SceneBattle):
	action_button_controller.update_button_set(unit,battle_scene)
	ui_unit_cards._update_all_labels(unit)


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
