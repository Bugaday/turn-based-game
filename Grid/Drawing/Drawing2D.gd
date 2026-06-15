extends Node2D

class_name Drawing2D

@onready var battle_manager : BattleManager = %BattleManager

#Selection Box
var SelectionBox : DrawBox
#Mouse Cursor Box
var MouseCursorBox : DrawBox
#Draw Path
var draw_move_path : DrawMovePath

#Grid Lines
var GridLines : Grid2DLines

func _draw() -> void:
	draw_circle(Vector2.ZERO,10.0,Color.RED)

func _setup():
	
	#MouseCursorBox = DrawBox.new()
	#add_child(MouseCursorBox)
	
	GridLines = Grid2DLines.new()
	add_child(GridLines)
	
	draw_move_path = DrawMovePath.new()
	add_child(draw_move_path)

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
	draw_move_path._drawPath(path)
	
func update_draw_path():
	draw_move_path.update_draw_path(battle_manager.character_selected.position)
	
func clear_path():
	draw_move_path.clear_path()
	
