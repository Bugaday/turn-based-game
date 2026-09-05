extends Node2D

class_name ActionCommand

signal start_finished()
signal execute_finished()
signal action_finished()

var action_name : String
var source_char : Character
var b_is_player_ : bool = false
var battle_scene_ : SceneBattle
#var target_

func _init(src_char:Character,battle_scene:SceneBattle,data:ActionData,b_is_player:bool) -> void:
	action_name = get_script().get_global_name()
	source_char = src_char
	battle_scene_ = battle_scene
	b_is_player_ = b_is_player
	#target_ = target
	start_finished.connect(execute_action)
	execute_finished.connect(end_action)


func start_action():
	var className:String = get_script().get_global_name()
	var log_string : String = "Starting action: " + className
	print(log_string)


func update_action():
	pass


func execute_action():
	var className:String = get_script().get_global_name()
	var log_string : String = "Executing action: " + className
	print(log_string)
	#await action_finished
	#end_action()


func end_action():
	#var unit:Character = source as Character
	#Util.delay_function(end_action,1.0,unit)
	
	var className:String = get_script().get_global_name()
	var log_string : String = "Finishing action: " + className
	print(log_string)
	action_finished.emit()
