extends Node2D

@export var gridCell : PackedScene

func _ready() -> void:
	CreateGrid()

# Called when the node enters the scene tree for the first time.
func CreateGrid() -> void:
	for x in GridProps2D.gridXCount:
		for y in GridProps2D.gridYCount:
			var gridCell_instance = gridCell.instantiate()
			add_child(gridCell_instance)
			gridCell_instance.cellID = x + y*GridProps2D.gridYCount
			gridCell_instance.global_position = Vector2(x*GridProps2D.cellSize,y*GridProps2D.cellSize)
			print(gridCell_instance. cellID);
			
