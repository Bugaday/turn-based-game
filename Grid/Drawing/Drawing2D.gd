extends Node2D

class_name Drawing2D

var input : InputController

#Selection Box
var SelectionBox : DrawSelectionBox
#Grid Lines
var GridLines : Grid2DLines


func _setup(inp:InputController):
	input = inp
	
	SelectionBox = DrawSelectionBox.new()
	add_child(SelectionBox)
	
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	
	inp.MouseGridPosChanged.connect(_on_Mouse_Grid_Pos_Changed)

func _on_Mouse_Grid_Pos_Changed(gridPos : Vector2i):
	SelectionBox.position = gridPos * GridProps2D.cellSize
	#SelectionBox.position = floor(get_global_mouse_position()/GridProps2D.cellSize.x)*GridProps2D.cellSize.x
