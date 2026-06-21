extends Node

class_name Pathfinder2D

var _astar : AStarGrid2D = AStarGrid2D.new()
var drawn_path : PackedVector2Array

func _ready() -> void:
	_astar.region = Rect2i(0, 0, GridProps2D.gridXCount, GridProps2D.gridYCount)
	_astar.cell_size = Vector2(64, 64)
	_astar.offset = GridProps2D.cellSize * 0.5
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ALWAYS
	_astar.update()


func set_blocked_cells(cell:Vector2i):
	_astar.set_point_solid(cell,true)
	
