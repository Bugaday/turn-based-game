extends Node2D

class_name Character

var currentCellPos : Vector2i
var currentHealth : int

@export var stats : UnitStats;

func _ready() -> void:
	if stats:
		_setStats(stats)

func _setStats(statData: Resource) -> void:
	stats = statData;
	%CharSprite2D.texture = stats.sprite
	currentHealth = stats.health
	#print(stats.health, " : ", currentHealth, " : ", stats.stamina)
