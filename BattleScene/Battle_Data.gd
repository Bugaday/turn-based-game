extends Node

class_name BattleData

signal on_set_active_character(unit:Character)
signal on_select_character(unit:Character)

var battle_script : Battle
var grid : Dictionary[Vector2i,GridCellData]
var pathfinder:Pathfinder2D
var tilemap:TileMapLayer

@export var battle_spawner : Spawner = Spawner.new()

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


func setup(battle:Battle) -> void:
	battle_script = battle
	grid = battle.grid
	pathfinder = battle.path_finder
	tilemap = battle.tile_map
	
	factions_in_battle = battle_spawner.factions
	all_characters = battle_spawner.spawn()
	for c in all_characters:
		c.position = GridService.GetRandomGridPosition(grid,tilemap)
		GridService.set_cell_unit_data_at_pos(c,grid)
		pathfinder.set_blocked_cells(GridService.world_to_grid(c.position))
		battle_script.add_child(c)
