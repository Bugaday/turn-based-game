extends Resource

class_name CharacterData

@export var unit_name : String = "Generic Unit";
#@export var faction_id : String
@export var stamina : int = 10;
@export var strength : int = 25;
@export var agility : int = 70
@export var sprite: AtlasTexture;

var extra_actions : Array[ActionCommand]

var action_points_max : int:
	get:
		return agility

func _init() -> void:
	action_points_max = agility

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
