extends Node

class_name AIDecisionMaker


static func make_decision(unit:Character,battle_scene:SceneBattle) -> AIDecision:
	var decision_scores : Dictionary[AIDecision,float]
	#Set scores in dictionary
	for decision in unit.available_decisions:
		if decision:
			if decision.get_action_points_required(unit,battle_scene) > unit.action_points_current:
				var className : String = decision.get_script().get_global_name()
				UIBattle.game_log.log(unit.character_name + " does not have enough action points in " + className)
				decision_scores[decision] = 0.0
			else:
				decision_scores[decision] = decision.get_score(unit,battle_scene)
	#UIBattle.game_log.log("Score is: " + str(get_highest_scoring_action(decision_scores)))
	return get_highest_scoring_action(decision_scores)


static func get_highest_scoring_action(decision_scores : Dictionary[AIDecision,float]) -> AIDecision:
	var highest_scoring_decision : AIDecision
	var highest_value : float = -INF
	for decision in decision_scores:
		var current_score = decision_scores[decision]
		if current_score > highest_value:
			highest_value = current_score
			highest_scoring_decision = decision
	#If the highest score is 0, that means that no decisions can be performed
	#due to, for example, no path to target, no viable targets, insufficient action points etc.
	if highest_value <= 0.0:
		print("All decisions have scored 0.0!")
		return null
	else:
		return highest_scoring_decision
