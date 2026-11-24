extends AIDecision

class_name AIDecisionMoveToEnemy


func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	var move_action : ActionCommand = battle_scene.battle_data.all_character_actions[unit.action_names[BattleData.ACTION_KEY.MOVE]]
	move_action.action_location_ = closest_enemy.position
	return move_action


func get_score(unit:Character,battle_scene:SceneBattle) -> float:
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
		var move_path : PackedVector2Array = battle_scene.path_finder.get_path_from_char(unit.position,closest_enemy.position,true)
		if move_path.size() > 1:
			return 1.0
		else:
			return 0.0
	else:  
		return 0.0
