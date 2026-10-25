extends Node

class_name AIDecisionMaker

signal all_actions_finished()

static func make_decision(unit:Character,battle_scene:SceneBattle) -> AIDecision:
	if !can_make_more_decisions(unit):
		return null
	var decision_scores : Dictionary[AIDecision,float]
	#Set scores in dictionary
	for decision in unit.available_decisions:
		if decision:
			decision_scores[decision] = decision._get_score(unit,battle_scene)
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
	if highest_value == 0.0:
		return null
	else:
		return highest_scoring_decision


static func can_make_more_decisions(unit:Character)->bool:
	if unit.action_points_current > 15:
		return true
	return false
