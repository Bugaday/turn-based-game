extends ActionData

class_name ActionDataAttack

func create_command(src_char:Character,battle_data:SceneBattle,action_data:ActionData,b_is_player:bool)->ActionCommand:
	return ActionCommandAttack.new(src_char,battle_data,self,b_is_player)
