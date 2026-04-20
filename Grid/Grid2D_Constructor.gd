extends Node2D

@export var gridCell : PackedScene

func _ready() -> void:
	CreateGrid()

# Called when the node enters the scene tree for the first time.
func CreateGrid() -> void:
	for i in GridProps2D.gridXCount:
		for j in GridProps2D.gridYCount:
			var gridCell_instance = gridCell.instantiate() as Node2D
			add_child(gridCell_instance)
			gridCell_instance.global_position = Vector2(i*GridProps2D.cellSize,j*GridProps2D.cellSize)
