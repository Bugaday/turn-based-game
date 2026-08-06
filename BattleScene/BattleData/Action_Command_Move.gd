extends ActionCommand

class_name ActionCommandMove

var start : Vector2
var end: Vector2


func _command_start():
	print("Starting move")


func _command_call():
	print("Moving command")


func _command_end():
	print("Ending move")
