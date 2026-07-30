@abstract
extends Resource

class_name Action

signal action_ended()


func _action_started():
	pass


func _action_ended():
	action_ended.emit()
