extends Node2D

class_name Drawing2D

@onready var battle_manager : BattleManager = %BattleManager
@onready var grid_controller : GridController = %TilesGround

#Selection Box
var SelectionBox : DrawBox
#Mouse Cursor Box
var MouseCursorBox : DrawBox
#Draw Path
var draw_preview_path : DrawMovePath
var draw_char_move_path : DrawCharMovePath

var char_moving : bool = false

#Grid Lines
var GridLines : Grid2DLines

func _draw() -> void:
	draw_circle(Vector2.ZERO,10.0,Color.RED)

func _setup():
	GridLines = Grid2DLines.new()
	add_child(GridLines)

	draw_preview_path = DrawMovePath.new()
	add_child(draw_preview_path)
	
func _process(delta: float) -> void:
	if(char_moving):
		draw_preview_path.draw_character_path_to_first_waypoint(battle_manager.character_selected.position)

func on_select_unit(cell : GridCellData):
	if !SelectionBox:
		SelectionBox = DrawBox.new()
		SelectionBox.BoxColour = Color.GREEN
		add_child(SelectionBox)
	SelectionBox.position = Vector2(cell.cell_pos*GridProps2D.cellSize)

func _on_Mouse_Grid_Pos_Changed(gridPos : Vector2i):
	MouseCursorBox.position = gridPos * GridProps2D.cellSize

func draw_path():
	draw_preview_path._drawPath(grid_controller.get_preview_path())
	
func draw_move_path():
	if grid_controller.current_path.size() > 0:
		if not draw_char_move_path:
			draw_char_move_path = DrawCharMovePath.new()
			add_child(draw_char_move_path)
		var start = battle_manager.character_selected.position
		var end = grid_controller.current_path[0]
		draw_char_move_path.set_points(start,end)
		draw_preview_path._drawPath(grid_controller.current_path)


func clear_path():
	draw_preview_path.clear_path()
	
