extends Resource

class_name BattleData

signal on_set_active_character(unit:Character)
signal on_select_character(unit:Character)

var battle_spawner : Spawner = Spawner.new()

var active_character : Character:
	set(value):
		active_character = value
		on_set_active_character.emit(active_character)
var selected_character : Character:
	set(value):
		selected_character = value
		on_select_character.emit(selected_character)


var all_characters : Array[Character]
var factions_in_battle : Array[String]
var active_faction : String = "Player"

var unit_blackboards : Dictionary[int,AIBlackboard] = {}
var battle_blackboard : BattleBlackboard = BattleBlackboard.new()
var global_blackboard : AIBlackboard = AIBlackboard.new()
var ai_registry : AIRegistry = AIRegistry.new(global_blackboard)


func _init() -> void:
	factions_in_battle = battle_spawner.factions
