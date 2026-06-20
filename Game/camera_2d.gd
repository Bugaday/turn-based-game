extends Camera2D

var pan_speed : float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GridCentreX : float = GridProps2D.gridSizeX / 2
	var GridCentreY : float = GridProps2D.gridSizeY / 2
	position = Vector2(GridCentreX,GridCentreY)
	
func _process(_delta: float) -> void:
	var input_dir : Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	global_position += input_dir * pan_speed * _delta
