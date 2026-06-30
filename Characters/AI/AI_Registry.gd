extends RefCounted

class_name AIRegistry

var faction_blackboards : Dictionary[String,AIBlackboard] = {}
var unit_blackboards : Dictionary[int,AIBlackboard] = {}

func register_faction(faction_id:String,parent_blackboard:AIBlackboard = null) -> AIBlackboard:
	#Create new blackboard to add to faction dictionary
	var bb = AIBlackboard.new(parent_blackboard)
	faction_blackboards[faction_id] = bb
	return bb
	
func register_unit(unit:Character,faction_id:String) -> AIBlackboard:
	
	var faction_bb = faction_blackboards.get(faction_id,null)
	#Create a new Blackboard for use by the passed-in Character
	var bb = AIBlackboard.new(faction_bb)
	#Add the Character's blackboard to the Unit Blackboards Dictionary
	unit_blackboards[unit.get_instance_id()] = bb
	return bb
