extends Action

class_name ActionMove

func _action_started(target:Object):
	battle_data.battle_script.draw_new_move_path(character_owner)
	pass

func _apply_effect(target:Object):
	pass
	
func _action_ended(target:Object):
	pass
