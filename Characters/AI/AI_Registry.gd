extends RefCounted

class_name AIRegistry

var faction_blackboards : Dictionary[String,AIBlackboard] = {}
var unit_blackboards : Dictionary[int,AIBlackboard] = {}

func register_faction(faction_id:String,parent_blackboard:AIBlackboard = null) -> AIBlackboard:
	#Create new blackboard to add to faction dictionary
	var bb = AIBlackboard.new(parent_blackboard)
	#Add the new Blackboard to the faction_blackboards dictionary
	faction_blackboards[faction_id] = bb
	return bb
	
func register_unit(unit:Character,faction_id:String) -> AIBlackboard:
	#Get the correct faction Blackboard from the passed in faction_id
	var faction_bb = faction_blackboards.get(faction_id,null)
	#Create a new Blackboard for use by the passed in Character
	var bb = AIBlackboard.new(faction_bb)
	#Add the new Character's blackboard to the unit_blackboards Dictionary
	# with the Character's instance id as its key and the newly created Blackboard as the value
	unit_blackboards[unit.get_instance_id()] = bb
	return bb

func get_unit_blackboard(unit:Character) -> AIBlackboard:
	return unit_blackboards.get(unit.get_instance_id(),null)
