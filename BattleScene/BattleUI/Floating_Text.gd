class_name FloatingText
extends Label

#var custom_font = load("res://path_to_your_font.tres")


func _init(text_to_display:String,pos:Vector2) -> void:
	#add_theme_font_override("normal_font", custom_font)
	text = text_to_display
	position = get_global_transform_with_canvas() * pos
	label_settings = load("res://Floating_Text_Settings.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self,"scale",Vector2(2.0,2.0),0.2)
	tween.tween_property(self,"position",Vector2(position.x,position.y-20.0),0.2)
	tween.tween_property(self,"modulate:a",0.0,0.2)
	tween.finished.connect(destroy_label)


func destroy_label():
	queue_free()
