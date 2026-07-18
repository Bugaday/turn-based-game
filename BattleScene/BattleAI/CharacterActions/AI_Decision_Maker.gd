extends RefCounted

class_name AIDecisionMaker

signal all_actions_finished()

var char_parent : Character

var available_actions : Array[AIAction] = []
var action_scores : Dictionary[AIAction,float] = {}


func start_decisions(unit:Character):
	char_parent = unit
	available_actions = char_parent.ai_actions_list.ai_actions
	if available_actions.size() <= 0:
		all_actions_finished.emit()
		return
		
	for action in available_actions:
		if !action.action_finished.is_connected(current_action_finished):
			action.action_finished.connect(current_action_finished)
		
	#print("Starting decision on ",char_parent.name," - ",char_parent.stats.unit_name)
	make_decision()._execute_action(char_parent)


func make_decision() -> AIAction:
	#print("Making decision on ",char_parent.name," - ",char_parent.stats.unit_name)
	#Reset the actions dictionary
	action_scores.clear()
	#Set scores in dictionary
	for action in available_actions:
		if action:
			action_scores[action] = action._get_score(char_parent)
			#print("Score is ",action_scores[action])
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
	
	
func current_action_finished():
	if can_make_more_decisions():
		make_decision()._execute_action(char_parent)
	else:
		all_actions_finished.emit()


func can_make_more_decisions()->bool:
	return false
