extends Node2D

class_name DrawMovePath

#Movement Path
var points : PackedVector2Array
var active_char : Character


func _drawPath(path_points : PackedVector2Array):
	if active_char and path_points.size() > 0:
		points = path_points.duplicate()
		queue_redraw()


func clear_path():
	points.clear()
	queue_redraw()


func _draw() -> void:
	if active_char and points.size() > 0:
		var point_colour : Color = Color.WHITE_SMOKE
		for i in len(points)-1:
			var point = points[i]
			var nextPoint = points[i+1]
			draw_line(point,nextPoint,point_colour,2.0)
			draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
			
		draw_line(active_char.position,points[0],point_colour,2.0)
		draw_circle(points[0],6.0,Color.WHITE_SMOKE)
			#var f = SystemFont.new()
			#draw_string(f,point+Vector2(0,-10.0),str(i))
