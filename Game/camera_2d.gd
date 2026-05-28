extends Camera2D

var InputCtrl : InputController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GridCentreX : float = GridProps2D.gridSizeX / 2
	var GridCentreY : float = GridProps2D.gridSizeY / 2
	position = Vector2(GridCentreX,GridCentreY)
	
func _process(delta: float) -> void:
	if (InputCtrl):
		position += Vector2(InputCtrl.MoveHorz * 10,InputCtrl.MoveVert * 10)
	pass
	
