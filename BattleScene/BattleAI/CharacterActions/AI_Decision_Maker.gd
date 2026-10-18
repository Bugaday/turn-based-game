extends Node

class_name AIDecisionMaker

signal all_actions_finished()

var char_parent : Character
var battle_scene : SceneBattle
var available_actions : Array[AIAction] = []
static var available_decisions : Array[AIDecision]
var action_scores : Dictionary[AIAction,float] = {}


func _init(_battle_scene:SceneBattle) -> void:
	battle_scene = _battle_scene
	var move_decision : Resource = load("res://BattleScene/BattleAI/CharacterActions/AI_Decision_Move_To_Enemy.gd")
	var attack_decision : Resource = load("res://BattleScene/BattleAI/CharacterActions/AI_Decision_Attack.gd")
	available_decisions.append(move_decision)
	available_decisions.append(attack_decision)
	
	
#static func chosen_action(unit:Character)->ActionCommand
	


func start_decisions(unit:Character):
	char_parent = unit
	available_actions = char_parent.ai_actions_list.ai_actions
	if available_actions.size() <= 0:
		all_actions_done()
		return
		
	for action in available_actions:
		if !action.action_done.is_connected(current_action_done):
			action.action_done.connect(current_action_done)
	var best_action : AIAction = make_decision(available_actions,unit,battle_scene)
	#if !best_action.action_done.is_connected(current_action_done):
		#best_action.action_done.connect(current_action_done,CONNECT_ONE_SHOT)
	#else:
		#TODO: Should check out these signal connections later!!
	best_action._execute_action(char_parent,battle_scene)


static func make_decision(all_actions:Array[AIAction],unit:Character,battle_scene:SceneBattle) -> AIAction:
	#Reset the actions dictionary
	var action_scores
	#Set scores in dictionary
	for action in all_actions:
		if action:
			action_scores[action] = action._get_score(unit,battle_scene)
	return get_highest_scoring_action(action_scores)


static func get_highest_scoring_action(action_scores : Dictionary[AIAction,float]) -> AIAction:
	var highest_scoring_action : AIAction
	var highest_value : float = -INF
	for action in action_scores:
		var current_score = action_scores[action]
		if current_score > highest_value:
			highest_value = current_score
			highest_scoring_action = action
	return highest_scoring_action


func current_action_done():
	if can_make_more_decisions():
		make_decision(available_actions,char_parent,battle_scene)._execute_action(char_parent,battle_scene)
	else:
		all_actions_done()


static func can_make_more_decisions()->bool:
	return false


func all_actions_done():
	all_actions_finished.emit()
