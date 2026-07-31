extends Node

class_name GameManager

@onready var input_state_machine : InputStateMachine = %InputStateMachine
@onready var camera_2d : Camera2D = %Camera2D
@onready var drawing_2D : Drawing2D = %Drawing2D

var ui_controller : UIController

#var characters : Array[Character]
#var charNum : int = 4;
#var DrawLines : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	ui_controller = UIController.new()
	
	#SETUP FUNCTIONS
	drawing_2D._setup()
