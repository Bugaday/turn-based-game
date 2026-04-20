extends Resource

class_name UnitStats

@export var unit_name : String = "Generic Unit";
@export var stamina : int = 10;
@export var strength : int =25;
@export var sprite: CompressedTexture2D;

#Offensive stats
var attackPower = strength * 2;

#Defensive stats
var health = stamina * 10;
