extends RefCounted

class_name StateGame

signal on_state_finished(new_state:StateGame)
signal on_hovering_unit(unit:Character)

enum Mouse_Hover_State{HOVER_CHARACTER,HOVER_MINI_CARD,HOVER_NONE = -1}
var mouse_current_hover_state : Mouse_Hover_State = Mouse_Hover_State.HOVER_NONE

func _enter_state(_battle_scene_script:SceneBattle):
	#Debug.log("Entering new state")
	pass


func handle_input(_event : InputEvent,_battle_scene_script:SceneBattle)->StateGame:
	return null


func Update(_delta: float,battle_scene:SceneBattle) -> void:
	if GridService.is_in_grid(battle_scene.get_global_mouse_position()):
		var mouseGridPos : Vector2i = GridService.world_to_grid(battle_scene.get_global_mouse_position())
		var cell_data : GridCellData = GridService.get_cell_data_at_pos(mouseGridPos,battle_scene.battle_data.grid)
		if cell_data.UnitOccupying:
			hover_character(battle_scene,cell_data.UnitOccupying)
			pass
		else:
			no_hover(battle_scene)
			pass
	else:
		no_hover(battle_scene)
		#battle_scene.battle_data.hovered_character = null
		pass


func hover_character(battle_scene:SceneBattle,unit:Character):
	battle_scene.ui_battle.on_character_hovered(unit,true)
	pass
	
func no_hover(battle_scene:SceneBattle):
	battle_scene.ui_battle.on_character_unhovered()
	pass


func _exit_state(_battle_scene_script:SceneBattle):
	#Debug.log("Exiting %s Input Mode"%state_machine.current_state.name,Color.RED)
	pass
