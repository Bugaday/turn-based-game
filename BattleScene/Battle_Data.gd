extends Resource

class_name BattleData

@export var factions : Array[String] = ["Player","Bandits"]
@export var min_num_units : int = 2
@export var max_num_units : int = 2
@export var allowed_classes : Array[CharacterData]
