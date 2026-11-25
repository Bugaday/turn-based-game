extends AIDecision

class_name AIDecisionMoveToEnemy


func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	var move_action : ActionCommand = battle_scene.battle_data.all_character_actions[unit.action_names[BattleData.ACTION_KEY.MOVE]]
	move_action.action_location_ = closest_enemy.position
	return move_action

func get_considerations():
	#Runs the functions needed to get info
	#Don't need to update these then every time any character does an action? Like moving or attacking
	considerations.clear()


func normalise_considerations():
	pass


func get_score(unit:Character,battle_scene:SceneBattle) -> float:
	var score : float = 1.0
	for con in considerations:
		score *= con
	
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	
	#Even if enemies are in range, we still need to find one with a valid movement path to it.
	if enemies_in_range.size() <= 0:
		var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
		var move_path : PackedVector2Array = battle_scene.path_finder.get_path_from_char(unit.position,closest_enemy.position,true)
		if move_path.size() > 1:
			return 1.0
		else:
			return 0.0
	else:  
		return 0.0
