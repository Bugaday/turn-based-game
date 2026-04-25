extends Node2D

var cellID : int;
var hover : bool = false;
var isBlocked : bool = false;
var hoverRect : Rect2;

	
func _draw() -> void:
	if hover:
		draw_rect(Rect2(Vector2.ZERO-Vector2(7,7),Vector2(14,14)),Color.RED,false,1.0,true)
		print("mouse is hovering!")
	#var idStr : String = str(cellID)
	#draw_string(ThemeDB.fallback_font,position,idStr)


func _on_area_2d_mouse_entered() -> void:
	hover = true;
	queue_redraw()
	print("Mouse is over cell: ", cellID) # Replace with function body.
	

func _on_area_2d_mouse_exited() -> void:
	hover = false;
	queue_redraw()
