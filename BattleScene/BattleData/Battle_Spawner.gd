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
