class_name UIBattle
extends Node


@export var action_button_controller : ActionButtonController
@export var ui_unit_card : UIUnitCard
var text_floating : FloatingText

#@onready var turn_text : Label = %TurnText
#@onready var battle_manager : BattleManager = %BattleManager
#
#@export var turn_finished_button : EndTurnButton


func hook_char_signals(all_units:Array[Character]) -> void:
	for unit in all_units:
		unit.on_current_stats_changed.connect(spawn_floating_text)


func spawn_floating_text(unit:Character,health:int):
	var string_health : String = str(abs(health))
	text_floating = FloatingText.new(string_health,Vector2(0.0,-32.0))
	unit.add_child(text_floating)


func on_character_selected(unit:Character,battle_scene : SceneBattle):
	action_button_controller.update_button_set(unit,battle_scene)
	ui_unit_card._setInfo(unit.stats)



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
