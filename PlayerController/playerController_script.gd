extends Node2D

class_name PlayerController

var selectedChar : Character
var GridLines : Grid2DLines
var SelectBox : HighLight2DRect
var MoveMode : bool = true

var font = ThemeDB.fallback_font

func _ready() -> void:
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	SelectBox = HighLight2DRect.new()
	add_child(SelectBox)

func _process(delta: float) -> void:
	SelectBox.position = floor(get_global_mouse_position()/GridProps2D.cellSize.x)*GridProps2D.cellSize.x


func _on_input_activate_move() -> void:
	MoveMode = not MoveMode
