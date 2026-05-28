extends Node2D

class_name DrawSelectionBox

var HighlightBox : Rect2 = Rect2(Vector2.ZERO,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
var Filled : bool = false
var BoxColour : Color = Color.YELLOW

func _draw() -> void:
	_drawSelectBox()
	
func _drawSelectBox():
	draw_rect(HighlightBox,BoxColour,Filled,2.0)
