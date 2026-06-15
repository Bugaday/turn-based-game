extends Node2D

var target_position : Vector2
var walk_duration : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	walk_duration = 2.0
	target_position = global_position + Vector2.RIGHT * 640
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, walk_duration)\
		.set_trans(Tween.TRANS_LINEAR)
