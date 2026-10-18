extends AIAction

class_name AIActionMoveToEnemy

var path : PackedVector2Array

func _execute_action(unit:Character,battle_scene:SceneBattle):
	super(unit,battle_scene)
	var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	var move_pos : Vector2i = GridService.world_to_grid(closest_enemy.position)
	var move_action : ActionCommand = ActionCommandMove.new(unit,battle_scene,unit.action_list[unit.ACTION.MOVE],false,move_pos)
	battle_scene.command_processor.add_action(move_action)
	move_action.action_finished.connect(action_finished)
	#ActionCommandMove.new(unit,)
	#EventBus.action_move_to_enemy.emit()
	#var start : Vector2i = GridService.world_to_grid(unit.position)
	#var end : Vector2i = Vector2i(3,4)
	#if !path:
		#get_move_path(start,end)
	#unit.start_move(path)
	#
	#if unit.path_finished.is_connected(finished_move):
		#return
	#unit.path_finished.connect(finished_move)
	#action_finished()


func finished_move(unit:Character):
	print("Finished move on: ", unit, " with id: ", get_instance_id())


func get_move_path(start:Vector2,end:Vector2):
	#path = GridService bm.grid_controller.get_astar2D_path(start,end)
	pass


#func get_in_range_enemies(bm:BattleManager)->Array[Character]:
	#var enemies : Array[Character] = bm.ai_registry.faction_unit_mappings


func _get_score(unit:Character,battle_scene:SceneBattle) -> float:
	super(unit,battle_scene)
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		return 1.0
	else:
		return 0.0
