extends Button

class_name EndTurnButton

var battle_scene : SceneBattle

func _ready() -> void:
	if get_tree().current_scene is SceneBattle:
		battle_scene = get_tree().current_scene
	else:
		push_error("Scene parent is not Battle Scene!")
	print(get_tree().current_scene)
	button_up.connect(on_button_up)


func enable_button():
	disabled = false


func disable_button():
	disabled = true


func on_button_up() -> void:
	print("End Turn Button pressed")
	battle_scene.end_turn()
