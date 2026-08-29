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


func get_path_from_char(start:Vector2,end:Vector2,partial:bool=false)->PackedVector2Array:
	var start_pos : Vector2i = GridService.world_to_grid(start)
	var end_pos : Vector2i = GridService.world_to_grid(end)
	set_cell_free(start_pos)
	var path:PackedVector2Array = _astar.get_point_path(start_pos,end_pos,partial)
	set_blocked_cell(start_pos)
	return path


func set_blocked_cell(cell:Vector2i):
	_astar.set_point_solid(cell,true)
	
func set_blocked_cell_from_vector2(pos:Vector2):
	var posi : Vector2i = GridService.world_to_grid(pos)
	set_blocked_cell(posi)
	
func set_cell_free(cell:Vector2i):
	_astar.set_point_solid(cell,false)


func set_cell_free_from_vector2(pos:Vector2):
	var posi : Vector2i = GridService.world_to_grid(pos)
	set_cell_free(posi)
