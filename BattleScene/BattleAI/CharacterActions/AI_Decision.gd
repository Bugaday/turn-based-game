@abstract
extends Resource

class_name AIDecision

signal action_done()


func _execute_action(_unit:Character,battle_scene:SceneBattle):
	if !battle_scene:
		push_error("No BattleManager found!")
		return
	pass


static func _get_score(_unit:Character,battle_scene:SceneBattle) -> float:
	if !battle_scene:
		push_error("No BattleManager found!")
		return 0
	return 0
	
	
func action_finished():
	action_done.emit()
