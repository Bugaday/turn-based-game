extends Resource

class_name Action

@export var action_name : String
@export var method_name : String
@export var signal_name : String
@export var method_args : Array


signal action_ended()


func _action_started():
	pass


func _apply_effect(target:Object):
	#if target.has_method(method_name):
		#target.call(method_name)
	if EventBus.has_signal(signal_name):
		EventBus.emit_signal(signal_name)


func _action_ended():
	action_ended.emit()
