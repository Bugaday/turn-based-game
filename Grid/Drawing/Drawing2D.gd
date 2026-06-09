extends Node2D

class_name Drawing2D

#Selection Box
var SelectionBox : DrawBox
#Mouse Cursor Box
var MouseCursorBox : DrawBox
#Draw Path
var DrawnPath : DrawMovePath

#Grid Lines
var GridLines : Grid2DLines


func _setup():
	
	MouseCursorBox = DrawBox.new()
	add_child(MouseCursorBox)
	
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	
	DrawnPath = DrawMovePath.new()
	add_child(DrawnPath)

func on_select_unit(cell : GridCellData):
	if !SelectionBox:
		SelectionBox = DrawBox.new()
		SelectionBox.BoxColour = Color.GREEN
		add_child(SelectionBox)
	SelectionBox.position = Vector2(cell.cell_pos*GridProps2D.cellSize)

func _on_Mouse_Grid_Pos_Changed(gridPos : Vector2i):
	MouseCursorBox.position = gridPos * GridProps2D.cellSize
	#DrawnPath._drawPath()
	
func draw_path(path:PackedVector2Array):
	DrawnPath._drawPath(path)
