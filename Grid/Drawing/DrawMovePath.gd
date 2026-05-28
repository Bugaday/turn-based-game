extends Node2D

class_name DrawMovePath

#Movement Path
var drawn_path : PackedVector2Array

var cellOffset : float = 0.0;
var cellSizeX : float = GridProps2D.cellSize.x;
var cellSizeY : float = GridProps2D.cellSize.y;
var gridXCount : int = GridProps2D.gridXCount;
var gridYCount : int = GridProps2D.gridYCount;
var gridSizeX : float = gridXCount * cellSizeX
var gridSizeY : float = gridYCount * cellSizeY

func _process(delta: float) -> void:
		#queue_redraw()
	#if input.MousePosX > 0 and input.MousePosX < GridProps2D.gridXCount:
		#if input.MousePosY > 0 and input.MousePosY < GridProps2D.gridYCount:
			#drawn_path = pathfinder.get_point_path(Vector2i(0, 0), Vector2(input.MousePosX,input.MousePosY))
			#queue_redraw()
	#else:
		#drawn_path.clear()
		#queue_redraw()
	pass
	
func _drawPath():	
	for i in len(drawn_path)-1:
		var point = drawn_path[i]
		var nextPoint = drawn_path[i+1]
		draw_line(point,nextPoint,Color.WHITE_SMOKE,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)

func _draw() -> void:
	#_drawPath()
	pass
