extends Node2D

class_name DrawAction

var valid_cells : PackedVector2Array
var targets : PackedVector2Array

var Filled : bool = true
var line_width : float = 2.0
var BoxColour : Color = Color.ORANGE_RED


func _draw() -> void:
	for i in valid_cells:
		var highlightCell : Rect2 = Rect2(i,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
		draw_rect(highlightCell,BoxColour,Filled,line_width)
	
func draw_items(validCells:PackedVector2Array,tgts:PackedVector2Array,width:float = 2.0):
	valid_cells.clear()
	targets.clear()
	valid_cells = validCells
	targets = tgts
	line_width = width
	queue_redraw()
