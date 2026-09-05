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


func update_button_set(unit:Character,battle_scene:SceneBattle):
	if buttons.size() <= 0:
		print("No buttons!")
		return
	for button in buttons:
		button.clear_action_button()
	for i in unit.action_list.size():
		#var action_keys : Array[String] = unit.action_list.keys()
		buttons[i].action_data = unit.action_list[unit.actions[i]]
		buttons[i].battle_scene = battle_scene
		buttons[i].char_linked = unit
		buttons[i].initialise_action_button()
		pass
