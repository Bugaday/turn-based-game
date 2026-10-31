class_name Character
extends Node2D

var character_name : String
var test_int : int = randi()
var char_last_cell_pos : Vector2
var faction : String
var weapons_available : Array[Weapon]
var weapon_current : Weapon

@export var char_sprite : Sprite2D
@export var base_stats : CharacterData
@onready var health_current : int = base_stats.health:
	set(value):
		health_current = value
		on_stat_changed.emit(self)
		check_health()
@onready var action_points_current : int = base_stats.action_points_max:
	set(value):
		action_points_current = value
		on_stat_changed.emit(self)
enum ACTION {MOVE,ATTACK}
@export var actions : Array[ACTION]
@export var action_list : Dictionary[ACTION,ActionData]
@export var available_decisions : Array[AIDecision]


signal on_stat_changed(unit:Character)

func _ready() -> void:
	if base_stats:
		weapons_available.append(preload("res://Weapons/Weapon_Unarmed.tres"))
		weapons_available.append(base_stats.class_weapon)
		weapon_current = base_stats.class_weapon
		_setStats()



func _setStats() -> void:
	char_sprite.texture = base_stats.sprite
	health_current = base_stats.health
	
func apply_health_change(amount:int):
	health_current += amount


func check_health():
	if health_current <= 0:
		die()
		
func die():
	print("Character has died!")
