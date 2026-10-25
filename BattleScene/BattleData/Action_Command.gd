extends Node2D

class_name ActionCommand

signal action_finished()

var action_name : String = "Unnamed Action"
var action_verb : String
var source_char : Character
var b_is_player_ : bool = false
var battle_scene_ : SceneBattle


func _init(src_char:Character,battle_scene:SceneBattle,_data:ActionData,b_is_player:bool) -> void:
	source_char = src_char
	battle_scene_ = battle_scene
	b_is_player_ = b_is_player


func start_action():
	var className : String = get_script().get_global_name()
	var log_string : String = "Starting action: " + className
	#print(log_string)


func update_action():
	pass


func action_input_confirm():
	execute_action()


func execute_action():
	var className:String = get_script().get_global_name()
	var log_string : String = source_char.character_name  + " is executing action: " + className + " with " + str(source_char.action_points_current) + " action points left."
	print(log_string)
	source_char.action_points_current -= calc_action_point_cost()
	#battle_scene_.ui_battle.game_log.log(source_char.base_stats.unit_name  + ": " + action_name + " - (" + str(source_char.action_points_current) + " action points left.)")

func end_action():
	var className:String = get_script().get_global_name()
	#var log_string : String = "Finishing action: " + className
	#print(log_string)
	action_finished.emit()
	
	
func calc_action_point_cost()->int:
	return 40
	
func log_action_verb():
	battle_scene_.ui_battle.active_unit_name.text = source_char.character_name + " " + action_verb
