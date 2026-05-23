extends Node2D

class_name PlayerController

var selectedChar : Character
var GridLines : Grid2DLines
var gridPosX : int
var gridPosY : int
var gridPos : Vector2i
var hoveredCell : GridCellData
var SelectBox : HighLight2DRect
var MoveMode : bool = true

var font = ThemeDB.fallback_font

func _ready() -> void:
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	SelectBox = HighLight2DRect.new()
	add_child(SelectBox)

func _process(delta: float) -> void:
	gridPosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	gridPosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	gridPos = %TilesGround.local_to_map(Vector2(gridPosX,gridPosY))

	hoveredCell = %LevelInit.Grid2D[gridPos]
	if hoveredCell.UnitOccupying != null :
		print(hoveredCell.UnitOccupying.currentHealth)
		
	SelectBox.position = floor(get_global_mouse_position()/GridProps2D.cellSize.x)*GridProps2D.cellSize.x


func _on_input_activate_move() -> void:
	MoveMode = not MoveMode


func _on_input_select() -> void:
	pass
	#SelectBox.Filled = true
	#SelectBox.queue_redraw()
