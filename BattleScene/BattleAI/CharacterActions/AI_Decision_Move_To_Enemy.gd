extends AIDecision

class_name AIDecisionMoveToEnemy


func _get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	var move_pos : Vector2i = GridService.world_to_grid(closest_enemy.position)
	var move_action : ActionCommand = ActionCommandMove.new(unit,battle_scene,unit.action_list[unit.ACTION.MOVE],false,move_pos)
	return move_action


func _get_score(unit:Character,battle_scene:SceneBattle) -> float:
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		return 1.0
	else:
		return 0.0
