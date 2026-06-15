extends Node2D

class_name Grid2DLines

var cellOffset : float = 0.0;
var cellSizeX : float = GridProps2D.cellSize.x;
var cellSizeY : float = GridProps2D.cellSize.y;
var gridXCount : int = GridProps2D.gridXCount;
var gridYCount : int = GridProps2D.gridYCount;
var gridSizeX : float = gridXCount * cellSizeX
var gridSizeY : float = gridYCount * cellSizeY

func _draw() -> void:
	for i in gridXCount + 1:
		draw_line(Vector2(i*cellSizeX,0.0),Vector2(i*cellSizeX,gridYCount*cellSizeY),Color.DARK_GRAY,2.0)
		pass
			
	for i in gridYCount + 1:
		draw_line(Vector2(0.0,i*cellSizeY),Vector2(gridXCount*cellSizeX,i*cellSizeY),Color.DARK_GRAY,2.0)
		pass
