extends Button

class_name ActionButton

var action : ActionCommand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(64.0,64.0)
	initialise_action_button()

	
func initialise_action_button():
	if !action:
		disabled = true
		return
	else:
		disabled = false
		text = action.action_name
		
func clear_action_button():
	text = ""
	disabled = true


func _pressed() -> void:
	print(text)
	action.start_action()
