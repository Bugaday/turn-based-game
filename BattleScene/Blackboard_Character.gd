extends RefCounted

class_name BlackboardCharacter

var local_data: Dictionary = {}

signal on_blackboard_value_set()

func get_value(key: String, default = null):
	#Check if key exists here first
	if local_data.has(key):
		return local_data[key]

	return default


#Sets value using Generic/Template/Untyped value allowing any type to be set
#Note, Unreal uses 'Set Blackboard Value as Float'
# or 'Set Blackboard Value as Object' which is strictly typed
func set_value(key: String, value) -> void:
	local_data[key] = value
	on_blackboard_value_set.emit()
