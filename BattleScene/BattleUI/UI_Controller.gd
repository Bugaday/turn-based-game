extends Node

class_name UIController

@onready var turn_text : Label = %TurnText
@onready var battle_manager : BattleManager = %BattleManager

@export var turn_finished_button : EndTurnButton


func _ready() -> void:
	turn_finished_button.on_turn_finished_pressed.connect(trigger_new_turn)
	EventBus.turn_finished.connect(trigger_new_turn)
	
func trigger_new_turn():
	battle_manager.faction_turn_finished()
	#set_turn_text()


func set_turn_text():
	if battle_manager.current_faction_index == 0:
		turn_text.text = "Player Turn"
	else:
		turn_text.text = "Enemy Turn"
