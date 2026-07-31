extends Node

signal ai_turn_started()
signal ai_turn_finished()

signal change_input_state(state:String)

signal start_move_on_path()

signal trigger_turn_finished()
#@warning_ignore("unused_signal")
signal try_select_character(pos:Vector2)

signal choose_move_position()

#@warning_ignore("unused_signal")
signal select_character(unit:Character)
#@warning_ignore("unused_signal")
signal action_move_to_enemy()

signal char_path_section_completed()

signal update_draw_move_path()

signal cancel_path()
