extends Node

class_name AIDecisions

var char_parent : Character

@export var available_actions : Array[AIAction] = []
var action_scores : Dictionary[AIAction,float] = {}

func _ready() -> void:
	char_parent = get_parent()

func make_decision() -> AIAction:
	#Reset the actions dictionary
	action_scores.clear()
	#Set scores in dictionary
	for action in available_actions:
		if action:
			action_scores[action] = action._get_score(char_parent)
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
