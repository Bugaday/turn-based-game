class_name Character
extends Node2D

var char_last_cell_pos : Vector2
var faction : String
var move_path : PackedVector2Array

var battle_data : BattleData

@export var char_sprite : Sprite2D
@export var stats : CharacterData
@export var health_ : CP_Health
#@export var draw_move_path : DrawMovePath
@export var ai_actions_list : AIActionsData
#@export var class_list : Array[AIAction]
enum ACTION {MOVE,ATTACK}
@export var actions : Array[ACTION]
@export var action_list : Dictionary[ACTION,ActionData]

signal on_current_stats_changed(unit:Character,health:int)

func _ready() -> void:
	if stats:
		_setStats()
	health_.on_health_changed.connect(check_health)


func _setStats() -> void:
	char_sprite.texture = stats.sprite
	

func check_health(amount_changed:int):
	on_current_stats_changed.emit(self,amount_changed)
	if health_.current_health <= 0:
		die()
		
func die():
	print("Character has died!")
