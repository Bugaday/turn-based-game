extends Node

class_name GridController

var tilemap : TileMapLayer
var pathfinder : Pathfinder2D
var Chars : Array[Character]
var cellSelected : GridCellData
var cell_hovered : GridCellData

signal character_hovered(character : Character)
signal cell_selected(cell : GridCellData)
signal send_move_preview_cells(movePreviewPoints : PackedVector2Array)

var Grid2D : Dictionary[Vector2i,GridCellData] = {}

func _process(delta: float) -> void:
	pass
		

func setup_grid(tmap : TileMapLayer):
	tilemap = tmap
	pathfinder = Pathfinder2D.new()
	add_child(pathfinder)
	Grid2D = Grid2DConstructor.CreateGrid()
	set_tiles()

func on_cell_clicked(pos:Vector2):
	#print("Running on_cell_clicked from Grid Controller at: ", cellSelected.cell_pos)
	var gridPos = tilemap.local_to_map(pos)
	cellSelected = Grid2D[gridPos]
	cell_selected.emit(cellSelected)
	pass
	
func get_move_preview_cells():
	var path_points : PackedVector2Array
	var start : Vector2 = cellSelected.cell_pos
	var end : Vector2 = cell_hovered.cell_pos
	path_points = pathfinder._astar.get_point_path(start,end)
	send_move_preview_cells.emit(path_points)
	
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

		tilemap.set_cell(i,0,pickedCell)
		#print(pickedCell, " : ", tilemap.get_cell_tile_data(pickedCell).get_custom_data(Block))
		
func on_chars_initialised(chars : Array[Character]):
	Chars = chars
	for i in Chars:
		add_child(i)
		var cell = GetRandomGridCell()
		Grid2D[cell].UnitOccupying = i
		i.currentCellPos = cell
		i.position = tilemap.map_to_local(cell)
