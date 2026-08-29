extends Resource

class_name Spawner

@export var factions : Array[String] = ["Player","Bandits"]
@export var min_num_units : int = 4
@export var max_num_units : int = 4
@export var allowed_classes : Array[CharacterData]


func spawn()->Array[Character]:
	var char_scene : PackedScene = load("res://BattleScene/CharacterRepresentations/Character.tscn")
	var char_array:Array[Character]
	
	for member : CharacterData in PlayerTeam.team_members.teamMembers:
		var newChar:Character = char_scene.instantiate()
		newChar.stats = member
		#newChar._setStats()
		newChar.faction = "Player"
		char_array.append(newChar)
	
	var num_units : int = randi_range(min_num_units,max_num_units)
	for i in num_units:
		var newChar : Character = char_scene.instantiate()
		var class_int : int = randi_range(0,allowed_classes.size()-1)
		var unit_class : CharacterData = allowed_classes[class_int]
		newChar.stats = unit_class
		newChar.faction = "Bandits"
		char_array.append(newChar)

	return char_array
		


#func spawn_player_team(char_scene:PackedScene)->Array[Character]:
	#return PlayerTeam.team_members
	#var player_team:Array[Character] = PlayerTeam.team_members
	#for team_member in player_team:
		#var newChar : Character = char_scene.instantiate()
		#newChar.stats = team_member.stats
		#newChar.faction = "Player"
		##newChar.action_finished.connect(handle_action_finished)
		#
		#parent_attach_node.add_child(newChar)
		#var grid_pos = GridService.GetRandomGridPosition(_grid,_tilemap)
		#newChar.position = grid_pos
		#GridService.set_cell_unit_data_at_pos(newChar,_grid)
		#path_finder.set_blocked_cell(GridService.world_to_grid(newChar.position))
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
		#path_finder.set_blocked_cell(GridService.world_to_grid(newChar.position))
