extends Node2D

@export var battle_data : BattleData

var characters : Array[Character]
var active_character : Character

var grid : Dictionary[Vector2i,GridCellData] = {}
var current_path : PackedVector2Array

@onready var tile_map : TileMapLayer = %BattleTileMap


func _ready() -> void:
	CreateGrid()
	spawn_characters()


func _draw() -> void:
	#Draw Grid Lines
	draw_grid_lines()


func CreateGrid():
	#Create Grid
	grid = GridService.CreateGrid()
	GridService.set_tiles(grid,tile_map)


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
		draw_line(Vector2(0.0,startPosY),Vector2(endPosX,startPosY),line_colour,2.0)


func spawn_characters():
	var new_char_scene : PackedScene = load("res://BattleScene/CharacterRepresentations/Character.tscn")
	spawn_player_team(new_char_scene)
	spawn_npcs(new_char_scene)


func spawn_player_team(char_scene:PackedScene):
	for c in PlayerTeam.team_members:
		var newChar : Character = char_scene.instantiate()
		add_child(newChar)
		characters.append(newChar)
		
		var grid_pos = GridService.GetRandomGridPosition(grid,tile_map)
		newChar.position = grid_pos


func spawn_npcs(char_scene:PackedScene):
	var num_units : int = randi_range(battle_data.min_num_units,battle_data.max_num_units)
	for i in num_units:
		var newChar : Character = char_scene.instantiate()
		var class_int : int = randi_range(0,battle_data.allowed_classes.size()-1)
		var unit_class : CharacterData = battle_data.allowed_classes[class_int]
		
		newChar.stats = unit_class
		add_child(newChar)
		characters.append(newChar)
		newChar.position = GridService.GetRandomGridPosition(grid,tile_map)
		#newChar.char_path_section_completed.connect(grid_controller.update_char_moved_data)
		#newChar.path_finished.connect(input_state_machine.character_finished_path)
		#grid_controller.set_char_moved_data(newChar)
