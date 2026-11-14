extends Resource

class_name CharacterData

@export var unit_name : String = "Generic Unit";
#@export var faction_id : String
@export var stamina : int = 10
@export var strength : int = 25
@export var agility : float = 70
@export var sprite: AtlasTexture
@export var class_weapon : Weapon = preload("res://Weapons/Weapon_Unarmed.tres")

var extra_actions : Array[ActionCommand]
var action_points_max : int = 100


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
		return float(max(100-agility,10.0))
