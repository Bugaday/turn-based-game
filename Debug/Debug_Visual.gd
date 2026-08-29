extends Node2D

class_name DebugVisual

var draw_debug : bool = false
var blocked_boxes : Array[Vector2i]
var occupied_boxes : Array[Vector2i]
var filled : bool = true
var line_width : float = 1.0
var box_colour : Color = Color(Color.TOMATO,0.4)
var battle : SceneBattle


func _ready() -> void:
	z_index = 1


func update_blocked_positions() -> void:
	blocked_boxes.clear()
	occupied_boxes.clear()
	if battle and battle.battle_data.grid:
		for cell_pos : Vector2i in battle.battle_data.grid.keys():
			if battle.path_finder._astar.is_point_solid(cell_pos):
				blocked_boxes.append(cell_pos)
			if battle.battle_data.grid[cell_pos].UnitOccupying:
				occupied_boxes.append(cell_pos)
	queue_redraw()


func _draw() -> void:
	if draw_debug:
		for pos:Vector2i in blocked_boxes:
			var position : Vector2 = GridService.grid_to_world(pos)
			position -= Vector2(GridProps2D.cellSize.x/2,GridProps2D.cellSize.y/2)
			var block_box : Rect2 = Rect2(position+Vector2(2.0,2.0),Vector2(GridProps2D.cellSize.x-4.0,GridProps2D.cellSize.y-4.0))
			draw_rect(block_box,box_colour,filled,line_width)
		for pos:Vector2i in occupied_boxes:
			var position : Vector2 = GridService.grid_to_world(pos)
			#position -= Vector2(32,32)
			draw_circle(position,12.0,Color.YELLOW,false,2.0,true)


func toggle():
	draw_debug = !draw_debug
	update_blocked_positions()


func _drawBox(width:float=1.0):
	line_width = width
	queue_redraw()
