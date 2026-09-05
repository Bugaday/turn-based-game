extends Button

class_name ActionButton

var battle_scene : SceneBattle
var action_data : ActionData
var char_linked : Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(64.0,64.0)
	initialise_action_button()


func initialise_action_button():
	if !action_data:
		disabled = true
		return
	else:
		disabled = false
		text = action_data.action_name


func clear_action_button():
	text = ""
	disabled = true


func _pressed() -> void:
	print(text)
	var action_ : ActionCommand = action_data.create_command(char_linked,battle_scene,action_data,true)
	battle_scene.command_processor.add_action(action_)
