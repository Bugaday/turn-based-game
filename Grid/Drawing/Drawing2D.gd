extends Node2D

class_name Drawing2D

var pathfinder : Pathfinder2D
var input : InputController

var GridLines : Grid2DLines
var SelectBox : HighLight2DRect
var drawn_path : PackedVector2Array

func _setup(pf:Pathfinder2D,inp:InputController):
	pathfinder = pf
	input = inp
	
func _drawGridLines():
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	#SelectBox = HighLight2DRect.new()
	#add_child(SelectBox)

func _process(delta: float) -> void:
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
	pass
	
	
func _drawMovePath():
	for i in len(drawn_path)-1:
		var point = drawn_path[i]
		var nextPoint = drawn_path[i+1]
		draw_line(point,nextPoint,Color.WHITE_SMOKE,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
