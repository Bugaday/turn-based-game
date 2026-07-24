extends Node2D

class_name DrawCursor

var HighlightBox : Rect2 = Rect2(Vector2.ZERO,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
var Filled : bool = false
var BoxColour : Color = Color.YELLOW


func _process(delta: float) -> void:
	position = GridService.snap_pos_to_grid(get_global_mouse_position()) 


func _draw() -> void:
	_drawBox()


func _drawBox():
	draw_rect(HighlightBox,BoxColour,Filled,4.0)
