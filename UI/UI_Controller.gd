extends Node

class_name UIController

@onready var turn_text : Label = %TurnText
@onready var battle_manager : BattleManager = %BattleManager


func _ready() -> void:
	EventBus.turn_finished.connect(set_turn_text)
	
func set_turn_text():
	if battle_manager.current_faction_index == 0:
		turn_text.text = "Player Turn"
	else:
		turn_text.text = "Enemy Turn"
