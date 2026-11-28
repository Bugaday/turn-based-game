extends AIDecision

class_name AIDecisionMoveToEnemy


func get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand:
	var closest_enemy : Character = unit.character_blackboard_.get_value("Closest_Enemy")
	var move_action : ActionCommand = battle_scene.battle_data.all_character_actions[unit.action_names[BattleData.ACTION_KEY.MOVE]]
	move_action.action_location_ = closest_enemy.position
	return move_action


func get_considerations(unit:Character,battle_scene:SceneBattle):
	#Clears the current considerations array first
	super(unit,battle_scene)
	
	var enemies_in_range : bool = AIDataPrep.enemies_in_range(unit,battle_scene)
	considerations.append(1.0-float(enemies_in_range))
	print("Enemies in range bool: ",enemies_in_range)


func normalise_considerations():
	pass


	#var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
#
	##Even if enemies are in range, we still need to find one with a valid movement path to it.
	#if enemies_in_range.size() <= 0:
		#var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
		#var move_path : PackedVector2Array = battle_scene.path_finder.get_path_from_char(unit.position,closest_enemy.position,true)
		#if move_path.size() > 1:
			#return 1.0
		#else:
			#return 0.0
	#else:  
		#return 0.0
