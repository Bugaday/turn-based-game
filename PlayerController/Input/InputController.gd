extends Node2D

class_name InputController

var _tilesGround : TileMapLayer

var MoveVert : float
var MoveHorz : float

var MousePosX : int
var MousePosY : int
var MouseGridPos : Vector2i
var MouseGridPosLast : Vector2i
var MouseGrid : Vector2

signal MouseGridPosChanged(GridPos : Vector2i)
signal Select(GridPos : Vector2i)


func _setup(tml:TileMapLayer):
	_tilesGround = tml
	
	MouseGridPos = _tilesGround.local_to_map(Vector2(MousePosX,MousePosY))
	MouseGridPosLast = MouseGridPos


func _unhandled_input(event):
	if event is InputEventKey:
		# Quit Game
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit() 


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		print("Mouse is selecting!")
		Select.emit(MouseGridPos)


func _process(_delta: float) -> void:
	MousePosX = clamp(get_global_mouse_position().x,0,GridProps2D.gridSizeX-GridProps2D.cellSize.x)
	MousePosY = clamp(get_global_mouse_position().y,0,GridProps2D.gridSizeY-GridProps2D.cellSize.y)
	MouseGridPos = _tilesGround.local_to_map(Vector2(MousePosX,MousePosY))
	
	if MouseGridPos != MouseGridPosLast:
		MouseGridPosChanged.emit(MouseGridPos)
		MouseGridPosLast = MouseGridPos
	
	MoveVert = Input.get_axis("MoveUp","MoveDown")
	MoveHorz = Input.get_axis("MoveLeft","MoveRight")
