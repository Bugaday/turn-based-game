extends Node2D

class_name Character

@export var stats : UnitStats;

func _setStats(statData: Resource) -> void:
	stats = statData;
	%CharSprite2D.texture = stats.sprite;
