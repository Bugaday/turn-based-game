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
		unit.character_blackboard.on_blackboard_value_set.connect(ui_unit_card._setInfo)
		unit.on_stat_changed.connect(ui_unit_card._update_info)
		#unit.on_current_stats_changed.connect(spawn_floating_text)
		pass


func spawn_floating_text(text,pos:Vector2,parent:Node2D):
	var string_ : String = str(text)
	text_floating = FloatingText.new(string_,pos)
	parent.add_child(text_floating)


func on_character_selected(unit:Character,battle_scene : SceneBattle):
	action_button_controller.update_button_set(unit,battle_scene)
	ui_unit_card._setInfo(unit)
	#ui_unit_card.add_label("Health : 100")
	#ui_unit_card.add_label("Action Points : 80")



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
