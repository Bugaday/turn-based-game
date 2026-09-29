extends RefCounted

class_name StateGame

signal on_state_finished(new_state:StateGame)
signal on_hovering_unit(unit:Character)

func _enter_state(_battle_scene_script:SceneBattle):
	#Debug.log("Entering new state")
	pass


func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	return null


func Update(_delta: float,_battle_scene_script:SceneBattle) -> void:
	var mouseGridPos : Vector2i = GridService.world_to_grid(_battle_scene_script.get_global_mouse_position())
	var cell_data : GridCellData = GridService.get_cell_data_at_pos(mouseGridPos,_battle_scene_script.battle_data.grid)
	if cell_data.UnitOccupying:
		_battle_scene_script.battle_data.hovered_character = cell_data.UnitOccupying
	else:
		_battle_scene_script.battle_data.hovered_character = null


func _exit_state(_battle_scene_script:SceneBattle):
	#Debug.log("Exiting %s Input Mode"%state_machine.current_state.name,Color.RED)
	pass
