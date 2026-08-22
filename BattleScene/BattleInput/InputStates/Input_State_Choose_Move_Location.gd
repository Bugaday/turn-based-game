extends InputState

class_name InputStateChooseMoveLocation

func _enter_state():
	super()
	#EventBus.update_draw_move_path.emit(battle_data.active_character)
	
func _exit_state():
	super()
	pass


func handle_input(_event : InputEvent):
	if _event is InputEventMouseMotion:
		EventBus.update_draw_move_path.emit(scene_data.active_character)
		pass
	elif _event.is_action_pressed("Escape") or _event.is_action_pressed("RightClick"):
		#EventBus.cancel_path.emit()
		change_state.emit("InputStateSelect")
	if _event.is_action_pressed("Select"):
		var data : BattleData = scene_data as BattleData
		var path : PackedVector2Array = data.pathfinder.get_path_from_char(data.selected_character.position,get_global_mouse_position(),true)
		var new_move = ActionCommandMove.new(scene_data.selected_character,path)
		call_action.emit(new_move)
		change_state.emit(%InputStateInputDisabled.name)


#func check_movable_location() -> bool:
	##var cell : GridCellData = grid_controller.get_cell_data(state_machine.mouse_pos)
	##if cell.UnitOccupying:
		##return false
	#return true
