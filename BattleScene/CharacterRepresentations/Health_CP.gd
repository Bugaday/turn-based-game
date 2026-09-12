class_name CP_Health
extends Node

var current_health : int = 100

signal on_health_changed(amount:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func apply_health_change(amount:int):
	current_health += amount
	on_health_changed.emit(amount)
