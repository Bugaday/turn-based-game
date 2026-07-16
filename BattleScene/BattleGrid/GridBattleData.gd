extends Resource

class_name GridBattleData

var owner : GridController

signal on_cell_updated()

var GridData : Dictionary[Vector2i,GridCellData] = {}
