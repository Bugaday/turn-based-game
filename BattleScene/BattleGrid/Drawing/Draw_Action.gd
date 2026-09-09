extends Node2D

class_name DrawAction

var valid_cells : PackedVector2Array
var targets : Array[Character]

var filled : bool = true
var line_width : float = 2.0
var inner_cell_margin : float = 6.0
var cell_colour : Color = Color(Color.RED,0.2)

func _draw() -> void:
	for i in valid_cells:
		var cell_to_vector2 : Vector2 = GridService.grid_to_world(i)-Vector2(GridProps2D.cellSize)/2+Vector2(inner_cell_margin/2.0,inner_cell_margin/2.0)
		var highlightCell : Rect2 = Rect2(cell_to_vector2,Vector2(GridProps2D.cellSize.x-inner_cell_margin,GridProps2D.cellSize.y-inner_cell_margin))
		draw_rect(highlightCell,cell_colour,filled)
	for i in targets:
		draw_circle(i.position,16.0,Color.YELLOW,false,4.0,true)
	
func draw_items(validCells:PackedVector2Array,tgts:Array[Character],width:float = 2.0):
	valid_cells.clear()
	targets.clear()
	valid_cells = validCells
	targets = tgts
	line_width = width
	queue_redraw()
