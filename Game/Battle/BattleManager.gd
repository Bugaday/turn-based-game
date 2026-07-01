extends Node

class_name BattleManager

var teamTurn : int = 0;
var teamCount : int = 1;
var charScene : PackedScene
var teams : Array[Team] = []
var characters : Array[Character]
var character_selected : Character
var ai_registry : AIRegistry

@onready var grid_controller : GridController = %TilesGround
@onready var drawing_2D : Drawing2D = %Drawing2D

func _ready() -> void:
	
	ai_registry = AIRegistry.new()
	ai_registry.register_faction(str(GameFeatures.factions.Enemy))

	charScene = preload("res://Characters/Character.tscn")

	var team1 : Team = load("res://Characters/Teams/team_3.tres")
	teams.append(team1)
	init_player_team()
	init_chars_ai()
	add_chars()
	
	# When initializing the match:
	var global_blackboard = AIBlackboard.new()
	global_blackboard.set_value("weather", "rain")

	var enemy_faction_blackboard = AIBlackboard.new(global_blackboard)
	enemy_faction_blackboard.set_value("player_spotted", false)

	# For each individual unit spawned:
	var goblin_blackboard = AIBlackboard.new(enemy_faction_blackboard)
	goblin_blackboard.set_value("is_wounded", true)
	
	EventBus.char_start_move.connect(start_move_character)
	
func init_player_team():
	var player_team : Team = load("res://Characters/Teams/team_player_temp.tres")
	for i in player_team.teamMembers:
		var newChar : Character = charScene.instantiate()
		newChar.stats = i
		PlayerTeam.team_members[newChar.get_instance_id()] = newChar
		characters.append(newChar)


func init_chars_ai():
	for i:int in teams.size():
		for j:int in teams[i].teamMembers.size():
			var newChar : Character = charScene.instantiate()
			newChar.stats = teams[i].teamMembers[j]
			newChar.faction = i
			ai_registry.register_unit(newChar,"Enemy")
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


func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
