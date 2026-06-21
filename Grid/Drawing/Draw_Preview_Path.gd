extends Node2D

class_name DrawMovePath

#Movement Path
var points : PackedVector2Array

var cellOffset : float = 0.0;
var cellSizeX : float = GridProps2D.cellSize.x;
var cellSizeY : float = GridProps2D.cellSize.y;
var gridXCount : int = GridProps2D.gridXCount;
var gridYCount : int = GridProps2D.gridYCount;
var gridSizeX : float = gridXCount * cellSizeX
var gridSizeY : float = gridYCount * cellSizeY


func _drawPath(path_points : PackedVector2Array):
	points = path_points.duplicate()
	queue_redraw()


func clear_path():
	points.clear()
	queue_redraw()


func _draw() -> void:
	for i in len(points)-1:
		var point = points[i]
		var nextPoint = points[i+1]
		var point_colour : Color = Color.WHITE_SMOKE
		draw_line(point,nextPoint,point_colour,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
		
		#var f = SystemFont.new()
		#draw_string(f,point+Vector2(0,-10.0),str(i))
		
