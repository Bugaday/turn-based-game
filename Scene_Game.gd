extends Node2D

class_name SceneGame

@export var scene_data : SceneData
var drawing : Drawing
@export var command_processor : CommandProcessor

func run_action_command(action:ActionCommand):
	if command_processor:
		command_processor.add_action(action)
