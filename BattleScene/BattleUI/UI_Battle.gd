extends Node

class_name UIBattle


@export var action_button_controller : ActionButtonController
@export var ui_unit_card : UIUnitCard

#@onready var turn_text : Label = %TurnText
#@onready var battle_manager : BattleManager = %BattleManager
#
#@export var turn_finished_button : EndTurnButton


func _ready() -> void:
	#turn_finished_button.on_turn_finished_pressed.connect(trigger_new_turn)
	#EventBus.turn_finished.connect(trigger_new_turn)
	pass
	
func on_character_selected(unit:Character):
	action_button_controller.update_button_set(unit)
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
