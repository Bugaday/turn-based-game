extends Resource

class_name Action

var battle_data : BattleData
var character_owner : Character

@export var callable_name : String
@export var callable_object : Variant
var command : ActionCommand
@export var action_name : String
@export var start_method_name : String
@export var method_name : String
@export var end_method_name : String
@export var signal_name : String
@export var start_method_args : Array
@export var method_args : Array
@export var execute_input : InputEventAction = null

#var start_method : Callable = Callable(callable_object,start_method_name)
#var callable_method : Callable = Callable(callable_object,callable_name)

signal action_started()
signal action_ended()



func _action_started(target:Object):
	#start_method.callv(start_method_args)
	#start_func.bindv(method_args)
	#start_func.call()
	action_started.emit()
	if target.has_method(start_method_name):
		target.call(start_method_name)
	else:
		_apply_effect(target)
	pass


func _apply_effect(target:Object):
	#effect_func.call()
	if target.has_method(method_name):
		target.call(method_name)
	else:
		_action_ended(target)
	#if EventBus.has_signal(signal_name):
		#EventBus.emit_signal(signal_name)


func _action_ended(target:Object):
	if target.has_method(method_name):
		target.call(method_name)
	#else:
		#action_ended.emit()
	#end_func.call()
	#action_ended.emit()
