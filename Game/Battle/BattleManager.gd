extends Node

class_name BattleManager

var teamTurn : int = 0;
var teamCount : int = 2;
var charScene : PackedScene
var teams : Array[Team]
var characters : Array[Character]
var character_selected : Character

@onready var grid_controller : GridController = %TilesGround
@onready var drawing_2D : Drawing2D = %Drawing2D

func _ready() -> void:
	charScene = preload("res://Characters/Character.tscn")
	var team0 : Team = load("res://Characters/Teams/team_0.tres")
	var team1 : Team = load("res://Characters/Teams/team_1.tres")
	teams.append(team0)
	teams.append(team1)
	init_chars()
	add_chars()


func init_chars():
	for i in teams.size():
		for j in teams[i].teamMembers.size():
			var newChar : Character = charScene.instantiate()
			newChar.stats = teams[i].teamMembers[j]
			characters.append(newChar)
	
func add_chars():
	for i in characters:
		add_child(i)
		var cell = grid_controller.GetRandomGridCell()
		grid_controller.Grid2D[cell].UnitOccupying = i
		i.currentCellPos = cell
		i.position = grid_controller.map_to_local(cell)

func selection_check_cell(mousepos : Vector2) -> GridCellData:
	var cell_clicked : GridCellData = grid_controller.get_cell_data(mousepos)
	if cell_clicked.UnitOccupying:
		character_selected = cell_clicked.UnitOccupying
		drawing_2D.on_select_unit(cell_clicked)
	return cell_clicked

func select_character(unit : Character):
	character_selected = unit

func endTurn() -> void:
	teamTurn = (teamTurn + 1) % teamCount;
