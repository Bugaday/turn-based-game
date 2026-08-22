extends Node2D

class_name InputGame

var scene_data : SceneGame
var input_state_machine : InputStateMachine


var campaign_input : InputCampaign
var battle_input : InputBattle

func _ready() -> void:
	scene_data = get_tree().get_first_node_in_group("SceneGame")
	input_state_machine = get_child(0)
	
	if scene_data == null:
		push_error("No scene data!")
	if input_state_machine == null:
		push_error("No Input State Machine!")
	
	input_state_machine._setup()
	
	scene_data.command_processor.on_queue_finish.connect(input_state_machine.enable_input)
	
	for state in input_state_machine.states:
		input_state_machine.states[state].call_action.connect(scene_data.run_action_command)
		pass
