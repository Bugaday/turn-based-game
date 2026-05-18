extends Camera2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GridCentreX : float = GridProps2D.gridSizeX / 2
	var GridCentreY : float = GridProps2D.gridSizeY / 2
	position = Vector2(GridCentreX,GridCentreY)
	
func _process(delta: float) -> void:
	#print("Local: ",get_local_mouse_position(), " : Global: ", get_global_mouse_position())
	pass
	
