extends TileMapLayer

class_name GridController

var pathfinder : Pathfinder2D
var Chars : Array[Character]
var cellSelected : GridCellData
var cell_hovered : GridCellData
var mouse_grid_pos : Vector2i

signal character_hovered(character : Character)

var Grid2D : Dictionary[Vector2i,GridCellData] = {}


func _ready() -> void:
	pathfinder = Pathfinder2D.new()
	add_child(pathfinder)
	Grid2D = Grid2DConstructor.CreateGrid()
	set_tiles()


func get_cell_data(pos:Vector2) -> GridCellData:
	var gridPos = local_to_map(pos)
	return Grid2D[gridPos]


func get_preview_path() -> PackedVector2Array:
	var path_points : PackedVector2Array
	path_points = pathfinder._astar.get_point_path(cellSelected.cell_pos,mouse_grid_pos)
	return path_points


func get_hovered_cell(cellPos : Vector2i):
	cell_hovered = Grid2D[cellPos]
	if cell_hovered.UnitOccupying:
		character_hovered.emit(cell_hovered.UnitOccupying)


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
	var weights = PackedFloat32Array([0.9,0.1])
	for i in Grid2D:
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]
		set_cell(i,0,pickedCell)


func on_chars_initialised(chars : Array[Character]):
	Chars = chars
	
