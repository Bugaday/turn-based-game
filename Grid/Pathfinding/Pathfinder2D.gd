extends Node2D

var _astar : AStarGrid2D = AStarGrid2D.new()
var drawn_path : PackedVector2Array

func _ready() -> void:
	_astar.region = Rect2i(0, 0, GridProps2D.gridXCount, GridProps2D.gridYCount)
	_astar.cell_size = Vector2(64, 64)
	_astar.offset = GridProps2D.cellSize * 0.5
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	#_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astar.update()
	#print(_astar.get_id_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (1, 1), (2, 2), (3, 3), (3, 4)]
	#print(_astar.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (16, 16), (32, 32), (48, 48), (48, 64)]

	
	
func _process(delta: float) -> void:
	var mousePos = %PlayerController.SelectBox.position / 64.0
	#print(mousePos)
	if %PlayerController.MoveMode:
		if mousePos.x > 0 and mousePos.x < GridProps2D.gridXCount:
			if mousePos.y > 0 and mousePos.y < GridProps2D.gridYCount:
				drawn_path = _astar.get_point_path(Vector2i(0, 0), mousePos)
				queue_redraw()
		else:
			drawn_path.clear()
			queue_redraw()

func _draw() -> void:
	for i in len(drawn_path)-1:
		var point = drawn_path[i]
		var nextPoint = drawn_path[i+1]
		#print(point," : ",nextPoint)
		draw_line(point,nextPoint,Color.WHITE_SMOKE,2.0)
		draw_circle(nextPoint,6.0,Color.WHITE_SMOKE)
