extends RefCounted

class_name AIRegistry

var global_blackboard : AIBlackboard
var faction_blackboards : Dictionary[String,AIBlackboard] = {}
var unit_blackboards : Dictionary[int,AIBlackboard] = {}
var faction_unit_mappings : Dictionary[String,Array] = {}

func _init(global:AIBlackboard) -> void:
	global_blackboard = global


func register_faction(faction_id:String,p_parent:AIBlackboard = null) -> AIBlackboard:
	#Godot's implementation of a ternary operator
	#If parent is left null, use the Global Blackboard, else use the passed in Blackboard
	var actual_parent = p_parent if p_parent != null else global_blackboard
	#Create new blackboard to add to faction dictionary
	var bb = AIBlackboard.new(actual_parent)
	#Add the new Blackboard to the faction_blackboards dictionary
	faction_blackboards[faction_id] = bb
	
	#Add a faction to the faction unit mappings if the passed in faction does not exist there.
	if not faction_unit_mappings.has(faction_id):
		faction_unit_mappings[faction_id] = [] as Array[Character]
	
	return bb


func register_unit(unit:Character,faction_id:String) -> AIBlackboard:
	#Get the correct faction Blackboard from the passed in faction_id
	var faction_bb = faction_blackboards.get(faction_id,null)
	#Create a new Blackboard for use by the passed in Character
	var bb = AIBlackboard.new(faction_bb)
	#Add the new Character's blackboard to the unit_blackboards Dictionary
	# with the Character's instance id as its key and the newly created Blackboard as the value
	unit_blackboards[unit.get_instance_id()] = bb
	
	#Add a faction to the faction unit mappings if the passed in faction does not exist there.
	if not faction_unit_mappings.has(faction_id):
		faction_unit_mappings[faction_id] = [] as Array[Character]
	#Add the unit to their correct faction group
	faction_unit_mappings[faction_id].append(unit)
	
	return bb


func get_unit_blackboard(unit:Character) -> AIBlackboard:
	return unit_blackboards.get(unit.get_instance_id(),null)
	
func get_faction_units(faction:String) -> Array[Character]:
	var units:Array[Character] = faction_unit_mappings.get(faction)
	return units
