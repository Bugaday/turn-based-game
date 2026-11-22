extends Resource

class_name ActionCommand

signal action_finished()

var action_name : String = "Unnamed Action"
var action_verb : String
var action_location_ : Vector2
var source_char : Character
var b_is_player_ : bool = false
var battle_scene_ : SceneBattle


func on_action_activated(unit:Character):
	source_char = unit
	if unit.faction == "Player":
		b_is_player_ = true
	else:
		b_is_player_ = false


func start_action():
	var className : String = get_script().get_global_name()
	var log_string : String = "Starting action: " + className
	#log_string)


func update_action():
	pass


func action_input_confirm():
	execute_action()


func execute_action():
	var className:String = get_script().get_global_name()
	var log_string : String = source_char.character_name  + " is executing action: " + className + " with " + str(source_char.action_points_current) + " action points left."
	source_char.action_points_current -= calc_action_point_cost()


func end_action():
	var className:String = get_script().get_global_name()
	battle_scene_.drawing_battle.draw_text.clear_text()
	action_finished.emit()


func calc_action_point_cost()->int:
	return 40


func show_action_point_cost_text(text_colour:Color=Color.WHITE):
	if calc_action_point_cost() > source_char.action_points_current:
		text_colour = Color.RED
	battle_scene_.drawing_battle.draw_text.draw_text_on_screen(str(calc_action_point_cost()),action_location_+Vector2(5,-5),text_colour)


func log_action_verb():
	battle_scene_.ui_battle.active_unit_name.text = source_char.character_name + " " + action_verb
