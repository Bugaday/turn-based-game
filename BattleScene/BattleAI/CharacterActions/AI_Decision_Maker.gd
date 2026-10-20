extends Node

class_name AIDecisionMaker

signal all_actions_finished()

#var char_parent : Character
#@export var battle_scene : SceneBattle
#var available_actions : Array[AIAction] = []
#var action_scores : Dictionary[AIAction,float] = {}


#func _init() -> void:
	#battle_scene = _battle_scene
	#var move_decision : Resource = load("res://BattleScene/BattleAI/CharacterActions/AI_Decision_Move_To_Enemy.gd")
	#var attack_decision : Resource = load("res://BattleScene/BattleAI/CharacterActions/AI_Decision_Attack.gd")
	#available_decisions.append(AIDecisionMoveToEnemy.new())
	#available_decisions.append(AIDecisionAttack.new())
	
	
#static func chosen_action(unit:Character)->ActionCommand
	


#static func start_decisions(unit:Character,battle_scene:SceneBattle):
	##char_parent = unit
	#if unit.available_decisions.size() <= 0:
		##all_actions_done()
		#return
		#
	##for decision in unit.available_decisions:
		##if !decision.action_done.is_connected(current_action_done):
			##decision.action_done.connect(current_action_done)
	##var best_decision : AIDecision = make_decision(unit.available_decisions,unit,battle_scene)
	##if !best_action.action_done.is_connected(current_action_done):
		##best_action.action_done.connect(current_action_done,CONNECT_ONE_SHOT)
	##else:
		##TODO: Should check out these signal connections later!!
	##best_decision._execute_action(char_parent,battle_scene)
	#return make_decision(unit,battle_scene)


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
	return highest_scoring_decision


static func current_action_done(unit:Character):
	if can_make_more_decisions(unit):
		pass
		#make_decision(char_parent.available_decisions,char_parent,battle_scene)._execute_action(char_parent,battle_scene)
	else:
		all_actions_done()


static func can_make_more_decisions(unit:Character)->bool:
	if unit.action_points_current > 20:
		return true
	return false


static func all_actions_done():
	#all_actions_finished.emit()
	pass
