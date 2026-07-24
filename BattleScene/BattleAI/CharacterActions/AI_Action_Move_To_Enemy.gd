extends AIAction

class_name ActionMoveToEnemy

var path : PackedVector2Array


func _execute_action(unit:Character):
	super(unit)

	var start : Vector2i = GridService.world_to_grid(unit.position)
	var end : Vector2i = Vector2i(3,4)
	if !path:
		get_move_path(start,end)
	unit.start_move(path)
	
	print("Action moving to enemy! by ",unit.name," - ",unit.stats.unit_name)
	
	if unit.path_finished.is_connected(finished_move):
		return
	unit.path_finished.connect(finished_move)


func finished_move(unit:Character):
	print("Finished move on: ", unit, " with id: ", get_instance_id())
	action_finished.emit()


func get_move_path(start:Vector2,end:Vector2):
	#path = GridService bm.grid_controller.get_astar2D_path(start,end)
	pass


#func get_in_range_enemies(bm:BattleManager)->Array[Character]:
	#var enemies : Array[Character] = bm.ai_registry.faction_unit_mappings


func _get_score(unit:Character) -> float:
	super(unit)

	return 0.5
