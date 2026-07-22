extends Resource

class_name CharacterData

@export var unit_name : String = "Generic Unit";
#@export var faction_id : String
@export var stamina : int = 10;
@export var strength : int = 25;
@export var agility : int = 70
@export var sprite: AtlasTexture;

var max_action_points : int = 100
var current_action_points : int

func _init() -> void:
	current_action_points = max_action_points

#Offensive stats
var attackPower:
	get:
		return strength * 2

#Defensive stats
var health : int:
	get:
		return stamina * 10;
		
var move_speed : float:
	get:
		return float(100-agility) / 10
