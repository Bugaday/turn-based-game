extends Node2D

var cellOffset : float = GridProps2D.cellSize/2;
var cellSize : float = GridProps2D.cellSize;
var gridXCount : int = GridProps2D.gridXCount;
var gridYCount : int = GridProps2D.gridYCount;
var gridSizeX : float = gridXCount * cellSize
var gridSizeY : float = gridYCount * cellSize

func _draw() -> void:
	for i in gridXCount:
		draw_line(Vector2(i*cellSize-cellOffset,-cellOffset),Vector2(i*cellSize-cellOffset,gridYCount*cellSize-cellOffset),Color.BLACK,1.0)
			
	for i in gridYCount:
		draw_line(Vector2(-cellOffset,i*cellSize-cellOffset),Vector2(gridXCount*cellSize-cellOffset,i*cellSize-cellOffset),Color.BLACK,1.0)
	
	draw_line(Vector2(-cellOffset,gridSizeY-cellOffset),Vector2(gridSizeX-cellOffset,gridSizeY-cellOffset),Color.BLACK,1.0)
	draw_line(Vector2(gridSizeX-cellOffset,-cellOffset),Vector2(gridSizeX-cellOffset,gridSizeY-cellOffset),Color.BLACK,1.0)
