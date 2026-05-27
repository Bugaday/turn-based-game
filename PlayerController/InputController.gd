extends Node2D

class_name InputController

var _tilesGround : TileMapLayer

var MousePosX : int
var MousePosY : int
var MouseGridPos : Vector2i

signal ActivateMove
signal Select

func _setup(tml:TileMapLayer):
	_tilesGround = tml
	

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		print("Mouse is selecting!")
		Select.emit()
		
func _process(delta: float) -> void:
	MousePosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	MousePosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	MouseGridPos = _tilesGround.local_to_map(Vector2(MousePosX,MousePosY))
