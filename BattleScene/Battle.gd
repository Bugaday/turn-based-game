extends Node2D

@export var battle_data : BattleData

@export var input_state_machine : InputStateMachine
@export var tile_map : TileMapLayer
@export var draw_box : DrawBox
@export var draw_move_path : DrawMovePath
@export var path_finder : Pathfinder2D

@export var player_team : Array[CharacterData]
@export var enemy_team : Array[CharacterData]

var ai_blackboard_global : AIBlackboard = AIBlackboard.new()
var ai_registry : AIRegistry = AIRegistry.new(ai_blackboard_global)
var ai_decision_maker : AIDecisionMaker = AIDecisionMaker.new()
var active_character : Character:
	set(value):
		active_character = value
		draw_move_path.active_char = value
var selected_character : Character
var active_faction_index : int = 0
var active_ai_char_index : int = 0
var active_factions : Array[String]
var active_faction_units : Array[Character]

var grid : Dictionary[Vector2i,GridCellData] = {}
var current_path : PackedVector2Array


func _ready() -> void:
	CreateGrid()
	determine_active_factions()
	spawn_characters()
	
	EventBus.try_select_character.connect(left_click_cell)
	EventBus.trigger_turn_finished.connect(faction_turn_finished)
	EventBus.start_move_on_path.connect(start_move_character)
	EventBus.action_move_to_enemy.connect(move_to_enemy)
	EventBus.update_draw_move_path.connect(draw_new_move_path)
	EventBus.cancel_path.connect(cancel_path)
	EventBus.char_path_section_completed.connect(character_finish_move)
	
	ai_decision_maker.all_actions_finished.connect(finish_ai_unit_turn)


func _process(delta: float) -> void:
	draw_move_path._drawPath(current_path)


func _draw() -> void:
	#Draw Grid Lines
	draw_grid_lines()
	
	#var pos = GridService.grid_to_world(Vector2i(1,1))
	#var posi = GridService.world_to_grid(Vector2(64,64))
	#var newpos = GridService.grid_to_world(posi)
	#draw_circle(newpos,16.0,Color.RED)
	#draw_circle(pos,16.0,Color.PURPLE)


func CreateGrid():
	#Create Grid
	grid = GridService.CreateGrid()
	GridService.set_tiles(grid,tile_map)
	add_blocked_tiles_for_pathfinder()


func add_blocked_tiles_for_pathfinder():
#Sets the tiles marked with 'Block' to disable points on the Path Finder	
	for i:Vector2i in grid.keys():
		var tile : TileData = tile_map.get_cell_tile_data(i)
		if tile.get_custom_data("Block"):
			path_finder.set_blocked_cells(i)


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


func determine_active_factions() -> void:
	active_factions.clear()
	active_factions = battle_data.factions
	active_factions.insert(0,"Player")
	for faction in active_factions:
		ai_registry.register_faction(faction)


func spawn_characters():
	var new_char_scene : PackedScene = load("res://BattleScene/CharacterRepresentations/Character.tscn")
	spawn_player_team(new_char_scene)
	spawn_npcs(new_char_scene)


func spawn_player_team(char_scene:PackedScene):
	for c in player_team:
		var newChar : Character = char_scene.instantiate()
		newChar.stats = c
		ai_registry.register_unit(newChar,"Player")
		newChar.action_finished.connect(handle_action_finished)
		
		add_child(newChar)
		var grid_pos = GridService.GetRandomGridPosition(grid,tile_map)
		newChar.position = grid_pos
		GridService.set_cell_unit_data_at_pos(newChar,grid)
		path_finder.set_blocked_cells(GridService.world_to_grid(newChar.position))


func spawn_npcs(char_scene:PackedScene):
	var num_units : int = randi_range(battle_data.min_num_units,battle_data.max_num_units)
	for c in enemy_team:
		var newChar : Character = char_scene.instantiate()
		var class_int : int = randi_range(0,battle_data.allowed_classes.size()-1)
		var unit_class : CharacterData = battle_data.allowed_classes[class_int]
		
		newChar.stats = c
		add_child(newChar)
		ai_registry.register_unit(newChar,"Bandits")
		newChar.position = GridService.GetRandomGridPosition(grid,tile_map)
		GridService.set_cell_unit_data_at_pos(newChar,grid)
		path_finder.set_blocked_cells(GridService.world_to_grid(newChar.position))


func left_click_cell(pos:Vector2):
	var posi : Vector2i = GridService.world_to_grid(pos)
	var cell_data : GridCellData = grid[posi]
	if cell_data.UnitOccupying:
		var unit : Character = cell_data.UnitOccupying
		if get_units_faction(unit) == "Player":
			select_character(unit)
	elif selected_character:
		input_state_machine.state_change(%InputStateSelectMovePoint.name)


func select_character(unit:Character):
	selected_character = unit
	active_character = unit
	draw_box.position = unit.position


func get_units_faction(unit:Character)->String:
	for key : String in ai_registry.faction_unit_mappings.keys():
		var characters : Array[Character] = ai_registry.get_faction_units(key)
		for c in characters:
			if c == unit:
				return key
	return "No Faction Found!"

func start_faction_turn():
	if active_factions[active_faction_index] == "Player":
		EventBus.ai_turn_finished.emit()
		EventBus.change_input_state.emit(%InputStateSelect.name)
		print("Player's turn!")
	else:
		print("AI's turn!")
		EventBus.ai_turn_started.emit()
		EventBus.change_input_state.emit(%InputStateInputDisabled.name)
		active_faction_units = ai_registry.get_faction_units(active_factions[active_faction_index])
		start_ai_unit_turn()


func faction_turn_finished():
	if active_factions.size() <= 0:
		return
	#Set the turn for the next faction
	active_faction_index = (active_faction_index + 1) % active_factions.size()
	%TurnText.text = active_factions[active_faction_index]
	start_faction_turn()


func start_ai_unit_turn():
	active_character = active_faction_units[active_ai_char_index]
	ai_decision_maker.start_decisions(active_character)


func finish_ai_unit_turn():
	if active_ai_char_index + 1 >= active_faction_units.size():
		active_ai_char_index = 0
		faction_turn_finished()
		return
	active_ai_char_index+=1
	start_ai_unit_turn()


func handle_action_started():
	if input_state_machine.current_state != %InputStateInputDisabled:
		input_state_machine.state_change(%InputStateInputDisabled.name)
	
	
func handle_action_finished():
	if active_factions[active_faction_index] == "Player":
		input_state_machine.state_change(%InputStateSelect.name)


func start_move_character():
	active_character.start_move(current_path)

func move_to_enemy():
	var end_pos:Vector2 = GridService.GetRandomGridPosition(grid,tile_map)
	current_path = path_finder.get_path_from_char(active_character.position,end_pos,true)
	active_character.start_move(current_path)


func character_finish_move():
	GridService.update_char_moved_data(active_character,grid)
	path_finder.set_cell_free_from_vector2(active_character.char_last_cell_pos)
	path_finder.set_blocked_cell_from_vector2(active_character.position)


func draw_new_move_path():
	current_path = path_finder.get_path_from_char(active_character.position,get_global_mouse_position(),true)
	draw_move_path._drawPath(current_path)

func cancel_path():
	current_path.clear()
	erase_drawn_path()
	
func erase_drawn_path():
	draw_move_path.clear_path()
