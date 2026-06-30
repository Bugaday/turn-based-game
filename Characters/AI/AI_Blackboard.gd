extends RefCounted

class_name AIBlackboard

var characters : Array[Character]

var local_data: Dictionary = {}
var parent_blackboard: AIBlackboard = null # Points to Faction or Global

func _init(_parent: AIBlackboard = null) -> void:
	parent_blackboard = _parent

func get_value(key: String, default = null):
	# 1. Check local memory first
	if local_data.has(key):
		return local_data[key]
	
	# 2. If not found locally, bubble up to the parent layer (Faction or Global)
	if parent_blackboard != null:
		return parent_blackboard.get_value(key, default)
		
	return default

func set_value(key: String, value) -> void:
	local_data[key] = value
