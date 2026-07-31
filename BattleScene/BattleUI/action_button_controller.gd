extends Control

var buttons : Array[ActionButton]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button_nodes : Array[Node] = get_children()
	for button in button_nodes:
		if button.is_class("ActionButton"):
			buttons.append(button)


func update_button_set(unit:Character):
	for i in unit.actions.size():
		buttons[i].action = unit.actions[i]
