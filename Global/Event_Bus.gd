extends Node

signal ai_turn_started()
signal ai_turn_finished()

signal change_input_state(state:String)

signal char_start_move()

signal trigger_turn_finished()
#@warning_ignore("unused_signal")
signal try_select_character(pos:Vector2)

#@warning_ignore("unused_signal")
signal select_character(unit:Character)
#@warning_ignore("unused_signal")
signal action_move_to_enemy()
