extends Node2D

class_name HighLight2DRect

var HighlightBox : Rect2 = Rect2(Vector2.ZERO,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
var Filled : bool = false
var BoxColour : Color = Color.GREEN

func _draw() -> void:
	draw_rect(HighlightBox,BoxColour,Filled,1.0)
