class_name Character
extends Node2D

var char_last_cell_pos : Vector2
var faction : String
var character_blackboard : BlackboardCharacter = BlackboardCharacter.new()

@export var char_sprite : Sprite2D
@export var stats : CharacterData
@export var health_ : CP_Health
@export var ai_actions_list : AIActionsData
#@export var class_list : Array[AIAction]
enum ACTION {MOVE,ATTACK}
@export var actions : Array[ACTION]
@export var action_list : Dictionary[ACTION,ActionData]
@onready var action_points_current : int = stats.action_points_max:
	set(value):
		action_points_current = value
		on_stat_change("Action Points",value)

signal on_stat_changed(value_name:String,value)

func _ready() -> void:
	if stats:
		_setStats()
	health_.on_health_changed.connect(on_stat_change)
	#character_blackboard.on_blackboard_value_set.connect(check_health)
	#health_.on_health_changed.connect(check_health)
	#character_blackboard.set_value("Stats",stats)
	#character_blackboard.set_value("Health",stats.health)
	#character_blackboard.set_value("Action Points",stats.action_points_max)


func _setStats() -> void:
	char_sprite.texture = stats.sprite
	
func on_stat_change(value_name:String,value):
	on_stat_changed.emit(value_name,value)

func check_health():
	#on_current_stats_changed.emit(self,amount_changed)
	if character_blackboard.get_value("Health") <= 0:
		die()
		
func die():
	print("Character has died!")
