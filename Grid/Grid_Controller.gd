extends TileMapLayer

class_name GridController

var pathfinder : Pathfinder2D
var cellSelected : GridCellData
var cell_hovered : GridCellData
var current_path : PackedVector2Array

var Grid2D : Dictionary[Vector2i,GridCellData] = {}


func _ready() -> void:
	pathfinder = Pathfinder2D.new()
	add_child(pathfinder)
	Grid2D = Grid2DConstructor.CreateGrid()
	set_tiles()
	
	call_deferred("check_for_blocked_cells")

func check_for_blocked_cells():	
	for i in Grid2D.keys():
		var tile : TileData = %TilesGround.get_cell_tile_data(i)
		if tile.get_custom_data("Block"):
			pathfinder.set_blocked_cells(i)
	pass
	
func set_cell_data(unit:Character):
	var gridPos : Vector2i = local_to_map(unit.position)
	Grid2D[gridPos].UnitOccupying = unit


func get_cell_data(pos:Vector2) -> GridCellData:
	var gridPos = local_to_map(pos)
	return Grid2D[gridPos]


func get_preview_path(mouse_pos:Vector2) -> PackedVector2Array:
	var cell_grid_pos : Vector2i = local_to_map(mouse_pos)
	current_path = pathfinder._astar.get_point_path(cellSelected.cell_pos,cell_grid_pos)
	return current_path


func GetRandomGridCell() -> Vector2i:
	var gridX : int = GridProps2D.gridXCount
	var gridY : int = GridProps2D.gridYCount
	var x : int = randi_range(0,gridX-1)
	var y : int  = randi_range(0,gridY-1)
	var randCell : Vector2i = Vector2i(x,y)
	while Grid2D[randCell].isOccupied:
		randCell = GetRandomGridCell()
		
	return randCell


func set_tiles():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.85,0.15])
	for i in Grid2D:
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]
		set_cell(i,0,pickedCell)
	
