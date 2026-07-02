extends Node

class_name BattleManager

var charScene : PackedScene
var characters : Array[Character]
var character_selected : Character

var teamCount : int = 2;
var teams : Array[Team] = []

var ai_registry : AIRegistry

@onready var turn_manager : TurnManager = %TurnManager
@onready var grid_controller : GridController = %TilesGround
@onready var drawing_2D : Drawing2D = %Drawing2D


func _ready() -> void:
	
	ai_registry = AIRegistry.new()
	ai_registry.register_faction(str(GameFeatures.factions.Enemy))

	charScene = preload("res://Characters/Character.tscn")
	var player_team : Team = load("res://Characters/Teams/team_player_temp.tres")
	var team1 : Team = load("res://Characters/Teams/team_3.tres")
	teams.append(player_team)
	teams.append(team1)
	init_player_team()
	init_chars_ai()
	add_chars()
	
	EventBus.char_start_move.connect(start_move_character)


func init_player_team():
	for i in teams[0].teamMembers:
		var newChar : Character = charScene.instantiate()
		newChar.stats = i
		PlayerTeam.team_members[newChar.get_instance_id()] = newChar
		characters.append(newChar)


func init_chars_ai():
	for i:int in teams.size():
		for j:int in teams[i].teamMembers.size():
			var newChar : Character = charScene.instantiate()
			newChar.stats = teams[i].teamMembers[j]
			ai_registry.register_unit(newChar,"Enemy")
			var bb: AIBlackboard = ai_registry.get_unit_blackboard(newChar)
			#bb.set_value()
			characters.append(newChar)


func add_chars():
	for i:Character in characters:
		add_child(i)
		var cell = grid_controller.GetRandomGridCell()
		grid_controller.Grid2D[cell].UnitOccupying = i
		i.position = grid_controller.map_to_local(cell)


func block_other_characters(unit_moving:Character):
	for unit in characters:
		if unit != unit_moving:
			grid_controller.set_blocked_position(unit.position)
	pass


func free_all_characters():
	for unit in characters:
		grid_controller.set_free_position(unit.position)


func select_character(from_position : Vector2):
	#var grid_pos = grid_controller.local_to_map(from_position)
	var cell : GridCellData = grid_controller.get_cell_data(from_position)
	if cell.UnitOccupying:
		character_selected = cell.UnitOccupying
		grid_controller.cellSelected = cell
		drawing_2D.on_select_unit(cell)


func start_move_character():
	character_selected.start_move(grid_controller.current_path)
