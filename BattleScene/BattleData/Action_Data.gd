extends Resource

class_name ActionData

@export var action_name : String
@export var action_command : GDScript

func create_command()->ActionCommand:
	#var new_action : ActionCommand = action_command.new()
	return action_command.new()
