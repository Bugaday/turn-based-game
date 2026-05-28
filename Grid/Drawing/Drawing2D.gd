extends Node2D

class_name Drawing2D

var pathfinder : Pathfinder2D
var input : InputController

#Grid Lines
var GridLines : Grid2DLines

#Movement Path
var drawn_path : PackedVector2Array

#Select Box
var HighlightBox : Rect2 = Rect2(Vector2.ZERO,Vector2(GridProps2D.cellSize.x,GridProps2D.cellSize.y))
var Filled : bool = true
var BoxColour : Color = Color.GREEN

func _setup(pf:Pathfinder2D,inp:InputController):
	pathfinder = pf
	input = inp
	
func _drawGridLines():
	GridLines = Grid2DLines.new()
	add_child(GridLines)


func _process(delta: float) -> void:
	
	HighlightBox.position = floor(get_global_mouse_position()/GridProps2D.cellSize.x)*GridProps2D.cellSize.x
	
	if input.MousePosX > 0 and input.MousePosX < GridProps2D.gridXCount:
		if input.MousePosY > 0 and input.MousePosY < GridProps2D.gridYCount:
			drawn_path = pathfinder.get_point_path(Vector2i(0, 0), Vector2(input.MousePosX,input.MousePosY))
			queue_redraw()
	else:
		drawn_path.clear()
		queue_redraw()

func _draw() -> void:
	_drawGridLines()
	_drawMovePath()
	_drawSelectBox()
	pass
	
func _drawSelectBox():
	draw_rect(HighlightBox,BoxColour,Filled,1.0)

	
func _drawMovePath():
	for i in len(drawn_path)-1:
		var point = drawn_path[i]
		var nextPoint = drawn_path[i+1]
		draw_line(point,nextPoint,Color.WHITE_SMOKE,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
