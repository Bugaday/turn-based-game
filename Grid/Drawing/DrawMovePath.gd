extends Node2D

class_name DrawMovePath

var points : PackedVector2Array

#Movement Path
var drawn_path : PackedVector2Array = [Vector2(0,0),Vector2(1,1)*(Vector2(GridProps2D.cellSize)/2),Vector2(1,2)*(Vector2(GridProps2D.cellSize)/2)]

var cellOffset : float = 0.0;
var cellSizeX : float = GridProps2D.cellSize.x;
var cellSizeY : float = GridProps2D.cellSize.y;
var gridXCount : int = GridProps2D.gridXCount;
var gridYCount : int = GridProps2D.gridYCount;
var gridSizeX : float = gridXCount * cellSizeX
var gridSizeY : float = gridYCount * cellSizeY
	
func _drawPath(path_points : PackedVector2Array):
	points = path_points
	queue_redraw()


func _draw() -> void:
	for i in len(points)-1:
		var point = points[i]
		var nextPoint = points[i+1]
		draw_line(point,nextPoint,Color.WHITE_SMOKE,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
