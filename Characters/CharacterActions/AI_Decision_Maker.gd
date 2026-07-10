extends RefCounted

class_name AIDecisionMaker

var char_parent : Character

var available_actions : Array[AIAction] = []
var action_scores : Dictionary[AIAction,float] = {}


func start_decisions(unit:Character):
	char_parent = unit
	available_actions = char_parent.ai_actions_list.ai_actions
	print("Starting decision on ",char_parent.name," - ",char_parent.stats.unit_name)
	make_decision()._execute_action(char_parent)
	EventBus.decisions_finished.emit()


func make_decision() -> AIAction:
	print("Making decision on ",char_parent.name," - ",char_parent.stats.unit_name)
	#Reset the actions dictionary
	action_scores.clear()
	#Set scores in dictionary
	for action in available_actions:
		if action:
			action_scores[action] = action._get_score(char_parent)
			print("Score is ",action_scores[action])
	return get_highest_scoring_action()


func get_highest_scoring_action() -> AIAction:
	var highest_scoring_action : AIAction
	var highest_value : float = -INF
	for action in action_scores:
		var current_score = action_scores[action]
		if current_score > highest_value:
			highest_value = current_score
			highest_scoring_action = action
	return highest_scoring_action
