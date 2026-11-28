extends AIDecision

class_name AIDecisionAttack


func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var attack_action : ActionCommand = battle_scene.battle_data.all_character_actions[unit.action_names[BattleData.ACTION_KEY.ATTACK]]
	attack_action.target = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	return attack_action


func get_score(unit:Character,battle_scene:SceneBattle) -> float:
	var enemies_in_range : Array[Character] = unit.character_blackboard_.get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		print("No enemies to attack!")
		return 0.0
	else:
		return 1.0
