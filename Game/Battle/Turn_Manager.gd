extends Node

class_name TurnManager

@onready var battle_manager : BattleManager = %BattleManager
@onready var end_turn_button : Button = %EndTurnButton
var teamTurn : int = 0


func _ready() -> void:
	end_turn_button.pressed.connect(endTurn)


func endTurn() -> void:
	teamTurn = (teamTurn + 1) % battle_manager.teamCount;
	EventBus.turn_finished.emit()
