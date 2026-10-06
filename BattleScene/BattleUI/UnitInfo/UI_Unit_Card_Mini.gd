class_name UIUnitCardMini
extends UIUnitCard

@export var progress_bar_health : ProgressBar
@export var progress_bar_resource : ProgressBar
@export var mini_card_button : Button
var character_linked : Character

signal on_mini_portrait_pressed(unit:Character,card:UIUnitCardMini)
signal card_character_hovered(unit:Character)

signal on_card_hovered(unit:Character)
signal on_card_unhovered(unit:Character)

func _ready() -> void:
	mini_card_button.pressed.connect(_pressed)
	mini_card_button.mouse_entered.connect(card_hovered)
	mini_card_button.mouse_exited.connect(card_unhovered)


func update_all_values(unit:Character):
	super(unit)
	progress_bar_health.max_value = unit.base_stats.health
	progress_bar_health.value = unit.health_current
	progress_bar_resource.max_value = unit.base_stats.action_points_max
	progress_bar_resource.value = unit.action_points_current


func _pressed() -> void:
	print("Mini card pressed!")
	on_mini_portrait_pressed.emit(character_linked,self)


func character_hovered_in_world():
	pass


func card_hovered():
	%Panel.visible = true
	card_character_hovered.emit(character_linked)
	


func card_unhovered():
	%Panel.visible = false
