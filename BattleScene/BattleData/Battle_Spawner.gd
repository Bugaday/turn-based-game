extends Resource

class_name Spawner

@export var factions : Array[String] = ["Player","Bandits"]
@export var min_num_units : int = 3
@export var max_num_units : int = 5
@export var allowed_classes : Array[CharacterData]

var parent_attach_node : Node
var _grid : Dictionary[Vector2i,GridCellData]
var _tilemap : TileMapLayer
var _pathfinder : Pathfinder2D





func spawn():
	var new_char_scene : PackedScene = load("res://BattleScene/CharacterRepresentations/Character.tscn")
	for faction_name in factions:
		var newChar : Character = new_char_scene.instantiate()
		newChar.position = GridService.GetRandomGridPosition(_grid,_tilemap)
		


#func spawn_player_team(char_scene:PackedScene):
	#for c in player_team:
		#var newChar : Character = char_scene.instantiate()
		#newChar.stats = c
		#newChar.faction = "Player"
		#newChar.action_finished.connect(handle_action_finished)
		#
		#parent_attach_node.add_child(newChar)
		#var grid_pos = GridService.GetRandomGridPosition(_grid,_tilemap)
		#newChar.position = grid_pos
		#GridService.set_cell_unit_data_at_pos(newChar,_grid)
		#path_finder.set_blocked_cells(GridService.world_to_grid(newChar.position))
#
#
#func spawn_npcs(char_scene:PackedScene):
	#var num_units : int = randi_range(min_num_units,max_num_units)
	#for c in enemy_team:
		#var newChar : Character = char_scene.instantiate()
		#var class_int : int = randi_range(0,allowed_classes.size()-1)
		#var unit_class : CharacterData = allowed_classes[class_int]
		#
		#newChar.stats = c
		#owner.add_child(newChar)
		#newChar.faction = "Bandits"
		#newChar.position = GridService.GetRandomGridPosition(_grid,_tile_map)
		#GridService.set_cell_unit_data_at_pos(newChar,grid)
		#path_finder.set_blocked_cells(GridService.world_to_grid(newChar.position))
