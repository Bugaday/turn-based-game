extends Resource

class_name Action


@export var callable_name : String
@export var callable_object : Variant
@export var command : ActionCommand
@export var action_name : String
@export var start_method_name : String
@export var method_name : String
@export var signal_name : String
@export var start_method_args : Array
@export var method_args : Array
@export var execute_input : InputEventAction = null

#var start_method : Callable = Callable(callable_object,start_method_name)
#var callable_method : Callable = Callable(callable_object,callable_name)

signal action_started()
signal action_ended()



func _action_started():
	#start_method.callv(start_method_args)
	#start_func.bindv(method_args)
	#start_func.call()
	#action_started.emit()
	#if target.has_method(start_method_name):
		#target.call(start_method_name)
	pass


func _apply_effect(effect_func:Callable):
	effect_func.call()
	#if target.has_method(method_name):
		#target.call(method_name)
	#if EventBus.has_signal(signal_name):
		#EventBus.emit_signal(signal_name)


func _action_ended(end_func:Callable):
	end_func.call()
	#action_ended.emit()
