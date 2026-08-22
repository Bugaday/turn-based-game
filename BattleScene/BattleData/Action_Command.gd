@abstract
extends RefCounted

class_name ActionCommand

signal start_finished()
signal execute_finished()
signal action_finished()

var source_char : Character
var target

func _init(src:Character=null,tar=null) -> void:
	source_char = src
	target = tar
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
