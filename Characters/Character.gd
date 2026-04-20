extends Node2D

class_name Character

@export var stats : UnitStats;
@export var spriteComp : Sprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _setStats(statData: Resource) -> void:
	stats = statData;
	spriteComp.texture = stats.sprite;
	
	if stats:
		print("I am a ", stats.unit_name, " with ", stats.health, " HP, and ", stats.attackPower, " attack power.")
