@abstract
extends Resource

class_name AIAction

signal action_finished()

@export var action_name : String = "Generic Action"
var bm : BattleManager

func _init() -> void:
	print("Loading resource: ", action_name)

func _execute_action(unit:Character):
	if !bm:
		print("No BattleManager found!")
		return
	print("Action ", resource_path, "! by ", unit.name," - ",unit.stats.unit_name)


func _get_score(unit:Character) -> float:
	if !bm:
		print("No BattleManager found!")
		return 0
	print("Scoring Action ", resource_path, "! by ", unit.name," - ",unit.stats.unit_name)
	return 0
