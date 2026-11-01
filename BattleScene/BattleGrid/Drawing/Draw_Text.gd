class_name DrawText
extends Node2D

var text_to_draw : String
var text_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func _draw() -> void:
	draw_string(SystemFont.new(),text_pos,text_to_draw)


func draw_text_on_screen(text:String,pos:Vector2):
	text_to_draw = text
	text_pos = pos
	queue_redraw()

func clear_text():
	text_to_draw = ""
	queue_redraw()
