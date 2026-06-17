extends Node2D

class_name DrawCharMovePath

#Char Movement Points
var char_pos : Vector2
var end_point : Vector2

func set_points(start:Vector2,end:Vector2):
	char_pos = start
	end_point = end
	queue_redraw()


func _draw() -> void:
	draw_line(char_pos,end_point,Color.WHITE_SMOKE,2.0)
	draw_circle(end_point,6.0,Color.WHITE_SMOKE)
