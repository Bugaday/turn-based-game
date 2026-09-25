@abstract
extends Resource

class_name AIAction

@export var action_name : String = "Generic Action"


func _init() -> void:
	call_deferred("print_name")


func _execute_action(_unit:Character):
	#if !bm:
		#push_error("No BattleManager found!")
		#return
	pass


func _get_score(_unit:Character) -> float:
	#if !bm:
		#push_error("No BattleManager found!")
		#return 0
	return 0


func print_name():
	#print("Loading resource: ", action_name)
	pass
