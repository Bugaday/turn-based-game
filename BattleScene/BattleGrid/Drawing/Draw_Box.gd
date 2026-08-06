extends Node2D

class_name DrawBox

var HighlightBox : Rect2 = Rect2(Vector2.ZERO-Vector2(GridProps2D.cellSize)/2,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
var Filled : bool = false
var line_width : float = 2.0
var BoxColour : Color = Color.ORANGE_RED


func _draw() -> void:
	draw_rect(HighlightBox,BoxColour,Filled,line_width)
	
func _drawBox(width:float = 2.0):
	line_width = width
	queue_redraw()
