extends Node2D

class_name GridService

# Called when the node enters the scene tree for the first time.
static func CreateGrid() -> Dictionary:
	var Grid2D : Dictionary[Vector2i,GridCellData]
	for x in GridProps2D.gridXCount:
		for y in GridProps2D.gridYCount:
			var coords : Vector2i = Vector2i(x,y)
			var newCell = GridCellData.new()
			newCell.cellID = x + y * GridProps2D.gridXCount
			newCell.cell_pos = Vector2i(x,y)
			Grid2D[coords] = newCell
			
	return Grid2D


static func set_tiles(grid:Dictionary,tilemap:TileMapLayer):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.9,0.1])
	for i in grid:
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]
		tilemap.set_cell(i,0,pickedCell)


static func GetRandomGridCell(grid:Dictionary,tilemap:TileMapLayer) -> Vector2i:
	var gridX : int = GridProps2D.gridXCount
	var gridY : int = GridProps2D.gridYCount
	var x : int = randi_range(0,gridX-1)
	var y : int  = randi_range(0,gridY-1)
	var randCell : Vector2i = Vector2i(x,y)
	var cell_data : TileData = tilemap.get_cell_tile_data(randCell)
	var cell_is_blocked : bool = cell_data.get_custom_data("Block")
	if grid[randCell].UnitOccupying or cell_is_blocked:
		randCell = GetRandomGridCell(grid,tilemap)
	
	return randCell


static func GetRandomGridPosition(grid:Dictionary,tilemap:TileMapLayer) -> Vector2:
	var cell : Vector2i = GetRandomGridCell(grid,tilemap)
	return tilemap.map_to_local(cell)


static func grid_world_clamp(pos:Vector2,tilemap:TileMapLayer)->Vector2:
	var x_clamp = clamp(pos.x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	var y_clamp = clamp(pos.y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	var grid_cell_pos = tilemap.local_to_map(Vector2(x_clamp,y_clamp))
	
	var clamp_pos = grid_cell_pos*GridProps2D.cellSize
	return clamp_pos
