extends Node2D

class_name Character

var currentHealth : int

@export var stats : UnitStats;

func _setStats(statData: Resource) -> void:
	stats = statData;
	%CharSprite2D.texture = stats.sprite;
	currentHealth = stats.health
	print(stats.health, " : ", currentHealth, " : ", stats.stamina)
