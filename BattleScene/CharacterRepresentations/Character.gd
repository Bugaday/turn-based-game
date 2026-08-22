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

@export var action_dictionary : Dictionary[String,Action]
var actions : Array[ActionCommand]

func _ready() -> void:
	if stats:
		_setStats()
	for action in actions:
		action.character_owner = self
		action_dictionary.set(action.action_name,action)

		
func start_action(action_name:String,target:Object):
	action_dictionary[action_name]._action_started(target)
 

func draw_path():
	#move_path = ba
	#draw_move_path._drawPath(position)
	pass



func _setStats() -> void:
	for action in stats.extra_actions:
		actions.append(action)
	char_sprite.texture = stats.sprite
