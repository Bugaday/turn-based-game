extends Node

class_name BattleManager

@export var charScene : PackedScene
var character_selected : Character

@export var battle_data : BattleData
var ai_registry : AIRegistry
var active_factions : Array[String] = []
var current_faction_index : int = 0

@onready var turn_manager : TurnManager = %TurnManager
@onready var grid_controller : GridController = %TilesGround
@onready var drawing_2D : Drawing2D = %Drawing2D


func _ready() -> void:
	
	ai_registry = AIRegistry.new()
	ai_registry.register_faction(str(GameFeatures.factions.Enemy))

	init_player_team()
	init_chars_ai()
	
	EventBus.char_start_move.connect(start_move_character)
	
func determine_active_factions() -> void:
	active_factions.clear()
	active_factions = battle_data.factions
	for faction in active_factions:
		ai_registry.register_faction(faction)


func init_player_team():
	for i in PlayerTeam.team_members:
		var newChar : Character = charScene.instantiate()
		add_child(newChar)
		newChar.position = grid_controller.GetRandomGridPosition()
		grid_controller.update_char_moved_data(newChar)


func init_chars_ai():
	if ai_registry.faction_blackboards.keys().is_empty():
		return
	for faction_blackboard_key:String in ai_registry.faction_blackboards.keys():
		if faction_blackboard_key == "Player":
			return
		var num_units : int = randi_range(battle_data.min_num_units,battle_data.max_num_units)
		for i in num_units:
			var newChar : Character = charScene.instantiate()
			var class_int : int = randi_range(0,battle_data.allowed_classes.size()-1)
			var unit_class : CharacterData = battle_data.allowed_classes[class_int]
			newChar.stats = unit_class
			
			ai_registry.register_unit(newChar,faction_blackboard_key)
			add_child(newChar)
			newChar.position = grid_controller.GetRandomGridPosition()
			grid_controller.update_char_moved_data(newChar)


func block_other_characters(unit_moving:Character):
	for unit:Character in ai_registry.unit_blackboards.keys():
		if unit != unit_moving:
			grid_controller.set_blocked_position(unit.position)
	pass


func free_all_characters():
	for unit:Character in ai_registry.unit_blackboards.keys():
		grid_controller.set_free_position(unit.position)


func select_character(from_position : Vector2):
	var cell : GridCellData = grid_controller.get_cell_data(from_position)
	if cell.UnitOccupying:
		character_selected = cell.UnitOccupying
		grid_controller.cellSelected = cell
		drawing_2D.on_select_unit(cell)


func start_move_character():
	character_selected.start_move(grid_controller.current_path)
