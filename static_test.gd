class_name StaticTest
extends Node

static var stat_int : int = 13
static var stat_char : Character
var normal_char : Character
var normal_int : int = 21
static var stat_string : String = "I'm a static String"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
static func do_static_things(unit:Character):
	stat_char = Character.new()
	stat_char = unit
	print(stat_char.test_int)
	
func do_things():
	normal_char = Character.new()
	print(normal_char.test_int)
	
