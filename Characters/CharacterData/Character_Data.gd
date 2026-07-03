extends Resource

class_name CharacterData

@export var unit_name : String = "Generic Unit";
@export var stamina : int = 10;
@export var strength : int = 25;
@export var sprite: AtlasTexture;

#Offensive stats
var attackPower:
	get:
		return strength * 2

#Defensive stats
var health : int:
	get:
		return stamina * 10;
