extends AIDecision

class_name AIDecisionAttack


func _get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var attack_action : ActionCommand = ActionCommandAttack.new(unit,battle_scene,unit.action_list[unit.ACTION.ATTACK],false)
	attack_action.target = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	return attack_action

func _execute_action(unit:Character,battle_scene:SceneBattle):
	super(unit,battle_scene)
	print("Executing attack action!")
	var attack_action : ActionCommand = ActionCommandAttack.new(unit,battle_scene,unit.action_list[unit.ACTION.ATTACK],false)
	attack_action.target = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	battle_scene.command_processor.add_action(attack_action)
	attack_action.action_finished.connect(action_finished)


func _get_score(unit:Character,battle_scene:SceneBattle) -> float:
	super(unit,battle_scene)
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		return 0.0
	else:
		return 1.0
