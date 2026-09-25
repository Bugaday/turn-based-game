class_name Character
extends Node2D

var char_last_cell_pos : Vector2
var faction : String
var character_blackboard : BlackboardCharacter = BlackboardCharacter.new()
var stats_dictionary : Dictionary[String,Variant] = {}

@export var char_sprite : Sprite2D
@export var base_stats : CharacterData
@export var health_ : CP_Health
@export var ai_actions_list : AIActionsData
#@export var class_list : Array[AIAction]
enum ACTION {MOVE,ATTACK}
@export var actions : Array[ACTION]
@export var action_list : Dictionary[ACTION,ActionData]
@onready var action_points_current : int = base_stats.action_points_max:
	set(value):
		action_points_current = value
		on_stat_change("Action Points",value)

signal on_stat_changed(value_name:String,value)

func _ready() -> void:
	if base_stats:
		_setStats()
	health_.current_health = base_stats.health
	health_.on_health_changed.connect(on_stat_change)
	
	
func get_stats_dictionary()->Dictionary[String,Variant]:
	stats_dictionary.clear()
	stats_dictionary.set("Name",base_stats.unit_name)
	stats_dictionary.set("Health",health_.current_health)
	stats_dictionary.set("Action Points",action_points_current)
	return stats_dictionary


func _setStats() -> void:
	char_sprite.texture = base_stats.sprite
	
func on_stat_change(value_name:String,value):
	on_stat_changed.emit(value_name,value)
	check_health()

func check_health():
	if health_.current_health <= 0:
		die()
		
func die():
	print("Character has died!")
