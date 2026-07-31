extends Control

class_name ActionButtonController

var buttons : Array[ActionButton]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button_nodes : Array[Node] = get_children()
	for button in button_nodes:
		print(button.get_class())
		if button.is_class("Button"):
			buttons.append(button)


func update_button_set(unit:Character):
	if buttons.size() <= 0:
		print("No buttons!")
		return
	for button in buttons:
		button.clear_action_button()
	for i in unit.actions.size():
		buttons[i].action = unit.actions[i]
		buttons[i].initialise_action_button()
