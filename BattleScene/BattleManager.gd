extends Node

class_name BattleManager

@onready var turn_manager : TurnManager = %TurnManager
@onready var grid_controller : GridController = %BattleTileMapLayer
@onready var drawing_2D : Drawing2D = %Drawing2D

@export var charScene : PackedScene
var character_selected : Character

@export var battle_data : BattleData
var ai_registry : AIRegistry
var ai_decision_maker : AIDecisionMaker
var active_factions : Array[String] = []
var current_faction_index : int = 0
var active_faction_units : Array[Character]
var active_ai_char_index : int = 0


func _ready() -> void:
	
	var global_blackboard = AIBlackboard.new()
	global_blackboard.set_value("turn_count", 1)
	global_blackboard.set_value("Weather", "Clear")
	
	ai_registry = AIRegistry.new(global_blackboard)
	ai_decision_maker = AIDecisionMaker.new()
	
	determine_active_factions()

	init_player_team()
	init_chars_ai()
	
	EventBus.char_start_move.connect(start_move_character)
	ai_decision_maker.all_actions_finished.connect(finish_ai_unit_turn)


func determine_active_factions() -> void:
	active_factions.clear()
	active_factions = battle_data.factions
	for faction in active_factions:
		ai_registry.register_faction(faction)


func init_player_team():
	for i in PlayerTeam.team_members:
		var newChar : Character = charScene.instantiate()
		ai_registry.register_unit(newChar,"Player")
		add_child(newChar)
		newChar.position = grid_controller.GetRandomGridPosition()
		grid_controller.set_char_moved_data(newChar)


func init_chars_ai():
	var ai_actions : AIActionsData = load("res://BattleScene/BattleAI/CharacterActions/Collections/AI_Actions_Default.tres")
	
	if ai_registry.faction_blackboards.keys().is_empty():
		return

	for faction_blackboard_key:String in ai_registry.faction_blackboards.keys():
		if faction_blackboard_key == "Player":
			continue
		var num_units : int = randi_range(battle_data.min_num_units,battle_data.max_num_units)
		for i in num_units:
			var newChar : Character = charScene.instantiate()
			var class_int : int = randi_range(0,battle_data.allowed_classes.size()-1)
			var unit_class : CharacterData = battle_data.allowed_classes[class_int]
			
			newChar.stats = unit_class
			ai_registry.register_unit(newChar,faction_blackboard_key)
			add_child(newChar)
			newChar.position = grid_controller.GetRandomGridPosition()
			grid_controller.set_char_moved_data(newChar)
			
			newChar.ai_actions_list = ai_actions
			
			for action:AIAction in newChar.ai_actions_list.ai_actions:
				action.bm = self


func block_other_characters(unit_moving:Character):
	for id:int in ai_registry.unit_blackboards.keys():
		if id != unit_moving.get_instance_id():
			var unit:Character = instance_from_id(id)
			grid_controller.set_blocked_position(unit.position)


func free_all_characters():
	for id:int in ai_registry.unit_blackboards.keys():
		var unit:Character = instance_from_id(id)
		grid_controller.set_free_position(unit.position)


func select_character(from_position : Vector2):
	var cell : GridCellData = grid_controller.get_cell_data(from_position)
	if cell.UnitOccupying:
		character_selected = cell.UnitOccupying
		grid_controller.cellSelected = cell
		drawing_2D.on_select_unit(cell)


func start_move_character():
	character_selected.start_move(grid_controller.current_path)


func start_faction_turn():
	if active_factions[current_faction_index] == "Player":
		EventBus.ai_turn_finished.emit()
		EventBus.change_input_state.emit(%InputStateSelection.name)
		print("Player's turn!")
	else:
		print("AI's turn!")
		EventBus.ai_turn_started.emit()
		EventBus.change_input_state.emit(%InputStateAITurn.name)
		active_faction_units = ai_registry.get_faction_units(active_factions[current_faction_index])
		start_ai_unit_turn()


func faction_turn_finished():
	current_faction_index = (current_faction_index + 1) % active_factions.size()
	%TurnText.text = active_factions[current_faction_index]
	start_faction_turn()


func start_ai_unit_turn():
	ai_decision_maker.start_decisions(active_faction_units[active_ai_char_index])


func finish_ai_unit_turn():
	if active_ai_char_index + 1 >= active_faction_units.size():
		active_ai_char_index = 0
		faction_turn_finished()
		return
	active_ai_char_index+=1
	start_ai_unit_turn()
