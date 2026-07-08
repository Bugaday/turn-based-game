extends TileMapLayer

class_name GridController

var pathfinder : Pathfinder2D
var Grid2D : Dictionary[Vector2i,GridCellData] = {}

#Mouse Position on Grid
var mouse_map_pos : Vector2i
var cell_hovered : GridCellData
var hovered_grid_pos : Vector2i
var hovered_grid_pos_last : Vector2i

var cellSelected : GridCellData
var current_path : PackedVector2Array

signal mouse_grid_pos_changed()

func _ready() -> void:
	pathfinder = Pathfinder2D.new()
	add_child(pathfinder)
	Grid2D = Grid2DConstructor.CreateGrid()
	set_tiles()
	
	EventBus.char_path_section_completed.connect(update_char_moved_data)
	
	call_deferred("add_blocked_cells_for_pathfinder")


func _process(delta: float) -> void:
	mouse_map_pos = local_to_map(get_local_mouse_position())
	var mouse_map_x_clamped = clamp(mouse_map_pos.x,0,GridProps2D.gridXCount-1)
	var mouse_map_y_clamped = clamp(mouse_map_pos.y,0,GridProps2D.gridYCount-1)
	hovered_grid_pos = Vector2i(mouse_map_x_clamped,mouse_map_y_clamped)
	cell_hovered = Grid2D[hovered_grid_pos]
	
	if hovered_grid_pos != hovered_grid_pos_last:
		mouse_grid_pos_changed.emit(hovered_grid_pos)
		hovered_grid_pos_last = hovered_grid_pos


func add_blocked_cells_for_pathfinder():	
	for i:Vector2i in Grid2D.keys():
		var tile : TileData = %TilesGround.get_cell_tile_data(i)
		if tile.get_custom_data("Block"):
			pathfinder.set_blocked_cells(i)
	pass


func set_blocked_position(pos:Vector2):
	var cell_at_pos : Vector2i = local_to_map(pos)
	pathfinder.set_blocked_cells(cell_at_pos)


func set_free_position(pos:Vector2):
	var cell_at_pos : Vector2i = local_to_map(pos)
	pathfinder.set_cell_free(cell_at_pos)


func set_cell_data(unit:Character):
	var gridPos : Vector2i = local_to_map(unit.position)
	Grid2D[gridPos].UnitOccupying = unit


func get_cell_data(pos:Vector2) -> GridCellData:
	var gridPos = local_to_map(pos)
	return Grid2D[gridPos]


func get_astar2D_path() -> PackedVector2Array:
	current_path = pathfinder._astar.get_point_path(cellSelected.cell_pos,hovered_grid_pos)
	return current_path


func set_char_moved_data(unit:Character):
	var grid_pos : Vector2i = local_to_map(unit.position)
	Grid2D[grid_pos].UnitOccupying = unit

func update_char_moved_data(unit: Character):
	var last_pos : Vector2i = local_to_map(unit.char_last_cell_pos)
	Grid2D[last_pos].UnitOccupying = null
	set_char_moved_data(unit)


func GetRandomGridCell() -> Vector2i:
	var gridX : int = GridProps2D.gridXCount
	var gridY : int = GridProps2D.gridYCount
	var x : int = randi_range(0,gridX-1)
	var y : int  = randi_range(0,gridY-1)
	var randCell : Vector2i = Vector2i(x,y)
	var cell_data : TileData = %TilesGround.get_cell_tile_data(randCell)
	var cell_is_blocked : bool = cell_data.get_custom_data("Block")
	if Grid2D[randCell].UnitOccupying or cell_is_blocked:
		randCell = GetRandomGridCell()
	
	return randCell
	
func GetRandomGridPosition() -> Vector2:
	var cell = GetRandomGridCell()
	return map_to_local(cell)


func set_tiles():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.9,0.1])
	for i in Grid2D:
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]
		set_cell(i,0,pickedCell)
