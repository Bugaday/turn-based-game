extends RefCounted

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
	#print(_astar.get_id_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (1, 1), (2, 2), (3, 3), (3, 4)]
	#print(_astar.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (16, 16), (32, 32), (48, 48), (48, 64)]
