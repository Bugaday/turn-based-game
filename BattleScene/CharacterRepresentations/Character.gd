extends Node2D

class_name Character

signal start_move_on_path()
signal action_started()
signal action_finished()
signal path_finished()

var char_last_cell_pos : Vector2
var faction : String
var move_path : PackedVector2Array

var battle_data : BattleData

@export var char_sprite : Sprite2D
@export var stats : CharacterData
@export var draw_move_path : DrawMovePath
@export var ai_actions_list : AIActionsData
@export var class_list : Array[AIAction]
enum ACTION {MOVE,ATTACK}
@export var actions : Array[ACTION]
@export var action_list : Dictionary[ACTION,ActionData]

func _ready() -> void:
	if stats:
		_setStats()


func _setStats() -> void:
	char_sprite.texture = stats.sprite
