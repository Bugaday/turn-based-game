extends RefCounted

class_name BattleBlackboard

signal blackboard_key_set(key:String)

var local_data: Dictionary = {}
var parent_blackboard: BattleBlackboard = null # Points to Faction or Global


#_init is Godot's constructor
func _init(_parent: BattleBlackboard = null) -> void:
	parent_blackboard = _parent


func get_value(key: String, default = null):
	#Check if key exists here first
	if local_data.has(key):
		return local_data[key]

	#If key not found, try the parent (Faction or Global)
	if parent_blackboard != null:
		return parent_blackboard.get_value(key, default)

	return default


#Sets value using Generic/Template/Untyped value allowing any type to be set
#Note, Unreal uses 'Set Blackboard Value as Float'
# or 'Set Blackboard Value as Object' which is strictly typed
func set_value(key: String, value) -> void:
	local_data[key] = value
	blackboard_key_set.emit(key)
