extends Node2D

class_name GridService

# Called when the node enters the scene tree for the first time.
static func CreateGrid() -> Dictionary[Vector2i,GridCellData]:
	var Grid2D : Dictionary[Vector2i,GridCellData]
	for x in GridProps2D.gridXCount:
		for y in GridProps2D.gridYCount:
			var coords : Vector2i = Vector2i(x,y)
			var newCell = GridCellData.new()
			newCell.cellID = x + y * GridProps2D.gridXCount
			newCell.cell_pos = Vector2i(x,y)
			Grid2D[coords] = newCell
			
	return Grid2D


static func set_tiles(grid:Dictionary[Vector2i,GridCellData],tilemap:TileMapLayer):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.9,0.1])
	for i in grid:
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]
		tilemap.set_cell(i,0,pickedCell)


static func get_cell_data_at_pos(pos:Vector2i,grid:Dictionary[Vector2i,GridCellData])->GridCellData:
	if grid.keys().has(pos):
		var cell_data : GridCellData = grid[pos]
		return cell_data
	else:
		print("No grid cell at: ",pos,"!")
		return null

	
static func set_cell_unit_data_at_pos(unit:Character,grid:Dictionary[Vector2i,GridCellData]):
	var grid_pos : Vector2i = world_to_grid(unit.position)
	var cell_data : GridCellData = grid[grid_pos]
	cell_data.UnitOccupying = unit


#static func get_move_path(start:Vector2,end:Vector2,tilemap:TileMapLayer)->PackedVector2Array:
	#tilemap.astar


static func GetRandomGridCell(grid:Dictionary[Vector2i,GridCellData],tilemap:TileMapLayer,restrict_start:Vector2i=Vector2i.ZERO,restrict_end:Vector2i=GridProps2D.gridExtents) -> Vector2i:
	var start_vector = grid_cell_clamp(restrict_start)
	var end_vector = grid_cell_clamp(restrict_end)
	var x : int = randi_range(start_vector.x,end_vector.x)
	var y : int  = randi_range(start_vector.y,end_vector.y)
	var randCell : Vector2i = Vector2i(x,y)
	var cell_data : TileData = tilemap.get_cell_tile_data(randCell)
	var cell_is_blocked : bool = cell_data.get_custom_data("Block")
	if grid[randCell].UnitOccupying or cell_is_blocked:
		randCell = GetRandomGridCell(grid,tilemap)
	
	return randCell


static func GetRandomGridPosition(grid:Dictionary[Vector2i,GridCellData],tilemap:TileMapLayer,restrict_start:Vector2i=Vector2i.ZERO,restrict_end:Vector2i=GridProps2D.gridExtents) -> Vector2:
	var cell_pos : Vector2i = GetRandomGridCell(grid,tilemap,restrict_start,restrict_end)
	return grid_to_world(cell_pos)


static func set_char_moved_data(unit:Character,grid:Dictionary[Vector2i,GridCellData]):
	var grid_pos : Vector2i = world_to_grid(unit.position)
	grid[grid_pos].UnitOccupying = unit


static func update_char_moved_data(unit: Character,grid:Dictionary[Vector2i,GridCellData]):
	var last_pos : Vector2i = world_to_grid(unit.char_last_cell_pos)
	grid[last_pos].UnitOccupying = null
	set_char_moved_data(unit,grid)


static func grid_world_clamp(pos:Vector2)->Vector2:
#Takes in a position (e.g. mouse) clamps that between 0 and the world float size of the grid
#Gets the grid coordinate at clamped position
#Returns the world position at grid coordinate to snap to grid
	var x_clamp = clamp(pos.x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	var y_clamp = clamp(pos.y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	var clamp_pos = Vector2(x_clamp,y_clamp)
	return clamp_pos
	
static func grid_cell_clamp(cell:Vector2i)->Vector2i:
	var clamped_cell = cell.clamp(Vector2i.ZERO,GridProps2D.gridExtents)
	return clamped_cell


static func snap_pos_to_grid(pos:Vector2)->Vector2:
	var clamped_pos : Vector2 = grid_world_clamp(pos)
	var grid_cell_pos = world_to_grid(clamped_pos)
	var snap_pos = grid_cell_pos*GridProps2D.cellSize
	return snap_pos


static func world_to_grid(pos:Vector2)->Vector2i:
	var clamped_pos : Vector2 = grid_world_clamp(pos)
	return clamped_pos / Vector2(GridProps2D.cellSize)
	

static func grid_to_world(pos:Vector2i)->Vector2:
	return pos * GridProps2D.cellSize + GridProps2D.cellSize / 2
