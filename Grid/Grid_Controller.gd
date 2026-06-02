extends RefCounted

class_name GridController

var tilemap : TileMapLayer
var pathfinder : Pathfinder2D

signal character_hovered(character : Character)

var Grid2D : Dictionary[Vector2i,GridCellData] = {}

func setup_grid(tmap : TileMapLayer):
	tilemap = tmap
	pathfinder = Pathfinder2D.new()
	
	Grid2D = Grid2DConstructor.CreateGrid()
	set_tiles()
	

func on_cell_clicked(grid_pos : Vector2i):
	print("Running on_cell_clicked from Grid Controller")
	var getCell : GridCellData = Grid2D[grid_pos]
	if getCell.UnitOccupying:
		print(getCell.UnitOccupying.stats.unit_name)
	pass
	
func on_hovered_cell(cellPos : Vector2i):
	var getCell : GridCellData = Grid2D[cellPos]
	if getCell.UnitOccupying:
		#print(getCell.UnitOccupying.stats.unit_name)
		character_hovered.emit(getCell.UnitOccupying)
		#%UnitCard.visible = true
		#%UnitCard._setInfo(getCell.UnitOccupying.stats,%TilesGround.map_to_local(cellPos))
	else:
		#%UnitCard.visible = false
		pass

func set_tiles():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var cells = [Vector2i(0,0),Vector2i(0,2)]
	var weights = PackedFloat32Array([0.9,0.1])
	
	for i in Grid2D:
			
		var pickedIndex = rng.rand_weighted(weights)
		var pickedCell : Vector2i = cells[pickedIndex]

		tilemap.set_cell(i,0,pickedCell)
