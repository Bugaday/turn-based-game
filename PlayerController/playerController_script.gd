extends Node2D

class_name PlayerController

var selectedChar : Character

var gridPosX : int
var gridPosY : int
var gridPos : Vector2i
var hoveredCell : GridCellData

var MoveMode : bool = true

var font = ThemeDB.fallback_font


func _process(delta: float) -> void:
	pass
		
	#SelectBox.position = floor(get_global_mouse_position()/GridProps2D.cellSize.x)*GridProps2D.cellSize.x


func _on_input_activate_move() -> void:
	MoveMode = not MoveMode


func _on_input_select() -> void:
	pass
