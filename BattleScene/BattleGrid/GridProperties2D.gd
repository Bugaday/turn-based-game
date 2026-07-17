extends RefCounted

class_name GridProps2D

static var cellSize : Vector2i = Vector2i(64.0,64.0);
static var gridXCount : int = 5;
static var gridYCount : int = 5;
static var grid_integer_range : Vector2i = Vector2i(gridXCount-1,gridYCount-1)
static var gridSizeX : float = gridXCount * cellSize.x
static var gridSizeY : float = gridYCount * cellSize.y
static var grid_float_size : Vector2 = Vector2(gridSizeX,gridSizeY)
