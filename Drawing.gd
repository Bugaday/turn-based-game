extends Node2D

class_name Drawing

@export var draw_box : DrawBox
@export var cursor : DrawCursor
@export var draw_move_path : DrawMovePath
@export var draw_action : DrawAction


func _draw() -> void:
	draw_grid_lines()


func draw_grid_lines():
	var line_colour = Color.DARK_GRAY
	var cellSizeX : float = GridProps2D.cellSize.x as float
	var cellSizeY : float = GridProps2D.cellSize.y as float
	#This draws a line top to bottom, spaced horizontally by cell size X
	for i in GridProps2D.gridXCount + 1:
		var startPosX : float = i*cellSizeX
		var endPosY : float = GridProps2D.gridYCount*GridProps2D.cellSize.y
		var startVector : Vector2 = Vector2(startPosX,0.0)
		var endVector : Vector2 = Vector2(startPosX,endPosY)
		draw_line(startVector,endVector,line_colour,2.0)
	
	#This draws a line left to right, spaced vertically by cell size Y
	for i in GridProps2D.gridYCount + 1:
		var startPosY : float = i*cellSizeY
		var endPosX : float = GridProps2D.gridXCount*cellSizeX
		var startVector : Vector2 = Vector2(0.0,startPosY)
		var endVector : Vector2 = Vector2(endPosX,startPosY)
		draw_line(startVector,endVector,line_colour,2.0)
