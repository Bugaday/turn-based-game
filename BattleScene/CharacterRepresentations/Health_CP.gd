class_name CP_Health
extends Node

var current_health : int = 100:
	set(value):
		current_health = value
		on_health_changed.emit("Health",value)

signal on_health_changed(name:String,amount:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func apply_health_change(amount:int):
	current_health += amount
