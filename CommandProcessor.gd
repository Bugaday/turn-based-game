extends Node

class_name CommandProcessor

signal on_queue_finish()

var command_queue : Array[ActionCommand]
var current_command : ActionCommand
var queue_running : bool


func _process(_delta: float) -> void:
	if current_command and current_command.has_method("update_action"):
		current_command.update_action()


func add_action(action:ActionCommand):
	command_queue.append(action)
	action.action_finished.connect(action_finished)
	start_queue()


func start_queue():
	if queue_running:
		return
	else:
		execute_queue()


func execute_queue():
	if command_queue.size() > 0:
		queue_running = true
		current_command = command_queue[0]
		current_command.action_finished.connect(execute_queue)
		current_command.start_action()
	else:
		queue_finished()


func action_finished():
	command_queue.remove_at(0)
	print("Action finished!")


func queue_finished():
	queue_running = false
	current_command = null
	print("Command queue finished!")
	on_queue_finish.emit()
