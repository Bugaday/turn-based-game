extends AIDecision

class_name AIDecisionMoveToEnemy

var path : PackedVector2Array

func _execute_action(unit:Character,battle_scene:SceneBattle):
	super(unit,battle_scene)
	var closest_enemy : Character = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Closest_Enemy")
	var move_pos : Vector2i = GridService.world_to_grid(closest_enemy.position)
	var move_action : ActionCommand = ActionCommandMove.new(unit,battle_scene,unit.action_list[unit.ACTION.MOVE],false,move_pos)
	battle_scene.command_processor.add_action(move_action)
	move_action.action_finished.connect(action_finished)


func finished_move(unit:Character):
	print("Finished move on: ", unit, " with id: ", get_instance_id())


static func _get_score(unit:Character,battle_scene:SceneBattle) -> float:
	super(unit,battle_scene)
	var enemies_in_range : Array[Character] = battle_scene.battle_data.ai_registry.unit_blackboards[unit].get_value("Enemies_in_Range")
	if enemies_in_range.size() <= 0:
		return 1.0
	else:
		return 0.0
