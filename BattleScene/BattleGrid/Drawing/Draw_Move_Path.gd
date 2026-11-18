extends Node2D

class_name DrawMovePath

#Movement Path
var draw_points : PackedVector2Array
var valid_cell_count : int = 0
var invalid_points : PackedVector2Array
var moving_char : Character = null


func _drawPath(path:PackedVector2Array,valid_cells:int,unit:Character):
	valid_cell_count = valid_cells
	moving_char = unit
	if path.size() > 0:
		draw_points = path.duplicate()
	queue_redraw()


func clear_path():
	draw_points.clear()
	queue_redraw()


func _draw() -> void:
	var point_colour : Color = Color.WHITE_SMOKE
	if draw_points.size() > 0:
		for i in range(draw_points.size()-1):
			if i < valid_cell_count:
				point_colour = Color.WHITE_SMOKE
			else:
				point_colour = Color.RED
			draw_line(draw_points[i],draw_points[i+1],point_colour,2.0)

		for i in range(draw_points.size()-1):
			if i < valid_cell_count:
				point_colour = Color.WHITE_SMOKE
			else:
				point_colour = Color.RED
			draw_circle(draw_points[i+1],6.0,point_colour)
		
		draw_line(moving_char.position,draw_points[0],Color.WHITE_SMOKE,2.0)
		draw_circle(draw_points[0],6.0,Color.WHITE_SMOKE)
