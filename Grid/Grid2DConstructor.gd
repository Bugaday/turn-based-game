extends Node2D

class_name Grid2DConstructor

# Called when the node enters the scene tree for the first time.
static func CreateGrid() -> Dictionary:
	var Grid2D : Dictionary[Vector2i,GridCellData]
	for x in GridProps2D.gridXCount:
		for y in GridProps2D.gridYCount:
			var coords : Vector2i = Vector2i(x,y)
			var newCell = GridCellData.new()
			newCell.cellID = x + y * GridProps2D.gridXCount
			newCell.cell_pos = Vector2i(x,y)
			Grid2D[coords] = newCell
			
	return Grid2D
