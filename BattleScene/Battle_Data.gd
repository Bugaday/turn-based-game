extends Node

class_name BattleData

var grid : Dictionary[Vector2i,GridCellData]
@export var tilemap:TileMapLayer
@export var battle_spawner : Spawner = Spawner.new()

signal on_character_hovered(unit:Character,bIsHovered:bool)
signal on_character_unhovered()

var active_character : Character:
	set(value):
		active_character = value
var selected_character : Character
var hovered_character : Character:
	set(value):
		if value == null:
			on_character_unhovered.emit()
		elif value != null and value != hovered_character:
			on_character_unhovered.emit()
			on_character_hovered.emit(value,true)
		hovered_character = value

var active_ai_char_index : int
var all_characters : Array[Character]
var factions_in_battle : Array[String]
var active_factions_units : Dictionary[String,Array] = {}
var active_faction : String = "Player"
var active_faction_index : int:
	set(value):
		active_faction_index = value
		active_faction = factions_in_battle[value]
var unit_blackboards : Dictionary[int,AIBlackboard] = {}
var battle_blackboard : BattleBlackboard = BattleBlackboard.new()
var global_blackboard : AIBlackboard = AIBlackboard.new()
var ai_registry : AIRegistry = AIRegistry.new(global_blackboard)


func setup(pathfinder:Pathfinder2D,ui:UIBattle) -> void:
	factions_in_battle = battle_spawner.factions
	for faction in factions_in_battle:
		active_factions_units[faction] = []
	all_characters = battle_spawner.spawn_all()
	for c in all_characters:
		active_factions_units[c.faction].append(c)
		c.position = GridService.GetRandomGridPosition(grid,tilemap)
		GridService.set_cell_unit_data_at_pos(c,grid)
		pathfinder.set_blocked_cell(GridService.world_to_grid(c.position))
		add_child(c)
