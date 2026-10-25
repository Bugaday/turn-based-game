extends Resource

class_name Spawner

@export var factions : Array[String] = ["Player","Bandits"]
@export var min_num_units : int = 4
@export var max_num_units : int = 4
@export var allowed_classes : Array[CharacterData]

var char_name_types : Dictionary[String,int]

signal new_character_spawned(unit:Character)


func spawn_all()->Array[Character]:
	var char_scene : PackedScene = load("res://BattleScene/CharacterRepresentations/Character.tscn")
	var char_array:Array[Character]
	char_name_types.clear()
	
	for member : CharacterData in PlayerTeam.team_members.teamMembers:
		var newChar:Character = char_scene.instantiate()
		newChar.base_stats = member
		if !char_name_types.has(newChar.base_stats.unit_name):
			char_name_types.set(newChar.base_stats.unit_name,1)
		newChar.character_name = newChar.base_stats.unit_name + " " + str(char_name_types[newChar.base_stats.unit_name])
		char_name_types[newChar.base_stats.unit_name] = char_name_types[newChar.base_stats.unit_name] + 1
		newChar.faction = "Player"
		char_array.append(newChar)
		new_character_spawned.emit(newChar)
	
	var num_units : int = randi_range(min_num_units,max_num_units)
	for i in num_units:
		var newChar : Character = char_scene.instantiate()
		var class_int : int = randi_range(0,allowed_classes.size()-1)
		var unit_class : CharacterData = allowed_classes[class_int]
		newChar.base_stats = unit_class
		if !char_name_types.has(newChar.base_stats.unit_name):
			char_name_types.set(newChar.base_stats.unit_name,1)
		newChar.character_name = newChar.base_stats.unit_name + " " + str(char_name_types[newChar.base_stats.unit_name])
		char_name_types[newChar.base_stats.unit_name] = char_name_types[newChar.base_stats.unit_name] + 1
		newChar.faction = "Bandits"
		char_array.append(newChar)
		new_character_spawned.emit(newChar)

	return char_array
	
	
