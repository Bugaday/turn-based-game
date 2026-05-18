extends Node2D

class_name HighLight2DRect

var HighlightBox : Rect2 = Rect2(Vector2.ZERO,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))

func _draw() -> void:
	draw_rect(HighlightBox,Color.RED,false,1.0)
