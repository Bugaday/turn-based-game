extends Node2D

class_name Battle

#signal on_select_character(unit:Character)

@export var battle_data : BattleData
@export var input_state_machine : InputStateMachine
@export var tile_map : TileMapLayer
@export var cursor_box : DrawCursor
@export var draw_box : DrawBox
@export var draw_move_path : DrawMovePath
@export var path_finder : Pathfinder2D
@export var ui_battle : UIBattleController

@export var player_team : Array[CharacterData]
@export var enemy_team : Array[CharacterData]

var ai_blackboard_global : AIBlackboard = AIBlackboard.new()
var ai_registry : AIRegistry = AIRegistry.new(ai_blackboard_global)
var ai_decision_maker : AIDecisionMaker = AIDecisionMaker.new()

var grid : Dictionary[Vector2i,GridCellData] = {}
var current_path : PackedVector2Array


func _ready() -> void:

	CreateGrid()
	
	input_state_machine.battle_data = battle_data
	input_state_machine._setup()
	
	battle_data.setup(self)
	#battle_data.on_set_active_character.co
	battle_data.on_select_character.connect(select_character)
	battle_data.battle_blackboard.blackboard_key_set.connect(blackboard_set)
	
	#EventBus.try_select_character.connect(left_click_cell)
	EventBus.trigger_turn_finished.connect(faction_turn_finished)
	EventBus.start_move_on_path.connect(start_move_character)
	EventBus.action_move_to_enemy.connect(move_to_enemy)
	EventBus.update_draw_move_path.connect(draw_new_move_path)
	EventBus.cancel_path.connect(cancel_path)
	EventBus.choose_move_position.connect(choose_move_location)
	EventBus.char_path_section_completed.connect(character_finished_move_section)
	
	ai_decision_maker.all_actions_finished.connect(finish_ai_unit_turn)


func _process(delta: float) -> void:
	if battle_data.active_character:
		draw_move_path._drawPath(battle_data.active_character.position,battle_data.active_character.move_path)


func _draw() -> void:
	#Draw Grid Lines
	draw_grid_lines()


func CreateGrid():
	#Create Grid
	grid = GridService.CreateGrid()
	GridService.set_tiles(grid,tile_map)
	add_blocked_tiles_for_pathfinder()
	input_state_machine._grid = grid


func add_blocked_tiles_for_pathfinder():
#Sets the tiles marked with 'Block' to disable points on the Path Finder	
	for i:Vector2i in grid.keys():
		var tile : TileData = tile_map.get_cell_tile_data(i)
		if tile.get_custom_data("Block"):
			path_finder.set_blocked_cells(i)


func blackboard_set(key:String):
	Callable(self,key).call()
	#var new_call : Callable = Callable(self,key).call()
	

func selected_character():
	print("Called selected character")
	

func active_character():
	print("Called active character")


func draw_grid_lines():
	var line_colour = Color.DARK_GRAY
	var cellSizeX : float = GridProps2D.cellSize.x as float
	var cellSizeY : float = GridProps2D.cellSize.y as float
	#This draws a line top to bottom, spaced horizontally by cell size X
	for i in GridProps2D.gridXCount + 1:
		var startPosX : float = i*cellSizeX
		var endPosY : float = GridProps2D.gridYCount*GridProps2D.cellSize.y
		var startVector : Vector2 = Vector2(startPosX,0.0)
		var endVector : Vector2 = Vector2(startPosX,endPosY)
		draw_line(startVector,endVector,line_colour,2.0)
	
	#This draws a line left to right, spaced vertically by cell size Y
	for i in GridProps2D.gridYCount + 1:
		var startPosY : float = i*cellSizeY
		var endPosX : float = GridProps2D.gridXCount*cellSizeX
		var startVector : Vector2 = Vector2(0.0,startPosY)
		var endVector : Vector2 = Vector2(endPosX,startPosY)
		draw_line(startVector,endVector,line_colour,2.0)





func choose_move_location():
	input_state_machine.state_change(%InputStateSelectMovePoint.name)


func select_character(unit:Character):
	#selected_character = unit
	#active_character = unit
	ui_battle.on_character_selected
	draw_box.position = unit.position





func start_faction_turn():
	if battle_data.active_faction == "Player":
		EventBus.ai_turn_finished.emit()
		EventBus.change_input_state.emit(%InputStateSelect.name)
		print("Player's turn!")
	else:
		print("AI's turn!")
		EventBus.ai_turn_started.emit()
		EventBus.change_input_state.emit(%InputStateInputDisabled.name)
		#battle_data.active_factions_units[battle_data.active_faction] = ai_registry.get_faction_units(battle_data.factions_in_battle[battle_data.active_faction_index])
		start_ai_unit_turn()


func faction_turn_finished():
	if battle_data.factions_in_battle.size() <= 0:
		return
	#Set the turn for the next faction
	battle_data.active_faction_index = (battle_data.active_faction_index + 1) % battle_data.factions_in_battle.size()
	#%TurnText.text = factions_in_battle[active_faction_index]
	start_faction_turn()


func start_ai_unit_turn():
	battle_data.active_character = battle_data.active_factions_units[battle_data.active_faction][battle_data.active_ai_char_index]
	ai_decision_maker.start_decisions(battle_data.active_character)
	pass


func finish_ai_unit_turn():
	if battle_data.active_ai_char_index + 1 >= battle_data.active_factions_units[battle_data.active_faction].size():
		battle_data.active_ai_char_index = 0
		faction_turn_finished()
		return
	battle_data.active_ai_char_index+=1
	start_ai_unit_turn()


func handle_action_started():
	if input_state_machine.current_state != %InputStateInputDisabled:
		input_state_machine.state_change(%InputStateInputDisabled.name)
	draw_box._drawBox(0.0)
	cursor_box._drawBox(0.0)


func handle_action_finished():
	if battle_data.factions_in_battle[battle_data.active_faction_index] == "Player":
		input_state_machine.state_change(%InputStateSelect.name)
		#draw_box.position = selected_character.position
		draw_box._drawBox()
		cursor_box._drawBox(4.0)


func start_move_character():
	#active_character.start_move(current_path)
	draw_box._drawBox(0.0)


func move_to_enemy():
	var end_pos:Vector2 = GridService.GetRandomGridPosition(grid,tile_map)
	#current_path = path_finder.get_path_from_char(active_character.position,end_pos,true)
	#active_character.start_move(current_path)
	pass


func character_finished_move_section():
	#GridService.update_char_moved_data(active_character,grid)
	#path_finder.set_cell_free_from_vector2(active_character.char_last_cell_pos)
	#path_finder.set_blocked_cell_from_vector2(active_character.position)
	pass


func draw_new_move_path(unit:Character):
	unit.move_path = path_finder.get_path_from_char(unit.position,get_global_mouse_position(),true)
	draw_move_path._drawPath(unit.position,unit.move_path)


func cancel_path(unit:Character):
	unit.move_path.clear()
	erase_drawn_path()


func erase_drawn_path():
	draw_move_path.clear_path()
