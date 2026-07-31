extends Button

class_name ActionButton

@export var action : Action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(64.0,64.0)
	if !action:
		disabled = true
		return
	text = action.action_name # Replace with function body.


func _pressed() -> void:
	action._apply_effect(owner)
