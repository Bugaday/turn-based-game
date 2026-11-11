class_name DrawText
extends Node2D

var text_to_draw : String
var text_pos : Vector2
var text_colour : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 99
	pass # Replace with function body.

	
func _draw() -> void:
	#Text shadow
	draw_string(SystemFont.new(),text_pos+Vector2(1,1),text_to_draw,HORIZONTAL_ALIGNMENT_CENTER,-1,20,Color.BLACK)
	#Main Text
	draw_string(SystemFont.new(),text_pos,text_to_draw,HORIZONTAL_ALIGNMENT_CENTER,-1,20,text_colour)


func draw_text_on_screen(text:String,pos:Vector2,col:Color):
	text_colour = col
	text_to_draw = text
	text_pos = pos
	queue_redraw()

func clear_text():
	text_to_draw = ""
	queue_redraw()
