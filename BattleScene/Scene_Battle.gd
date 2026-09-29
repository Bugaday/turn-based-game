extends Node2D

class_name SceneBattle

@export var battle_data : BattleData
@export var path_finder : Pathfinder2D
@export var drawing_battle : Drawing
@export var ui_battle : UIBattle
@export var command_processor : CommandProcessor

var current_state : StateGame

func _ready() -> void:
	
	DebugVis.battle = self 
	
	CreateGrid()
	battle_data.setup(path_finder)
	battle_data.on_character_hovered.connect(ui_battle.on_character_hovered)
	ui_battle.ui_unit_cards.ui_unit_mini_cards_group.update_mini_cards(battle_data.active_factions_units,self)
	#for card :  UIUnitCardSelectionCard in ui_battle.ui_unit_cards.ui_unit_mini_cards_group.ui_unit_mini_cards_player.get_children():
		#card.on_mini_portrait_pressed.connect(mini_card_selected)
	DebugVis.update_blocked_positions()


func CreateGrid():
	battle_data.grid = GridService.CreateGrid()
	GridService.set_tiles(battle_data.grid,battle_data.tilemap)
	add_blocked_tiles_for_pathfinder()


func add_blocked_tiles_for_pathfinder():
#Sets the tiles marked with 'Block' to disable points on the Path Finder	
	for i:Vector2i in battle_data.grid.keys():
		var tile : TileData = battle_data.tilemap.get_cell_tile_data(i)
		if tile.get_custom_data("Block"):
			path_finder.set_blocked_cell(i)
			
			
func mini_card_selected(unit:Character,card:UIUnitCardSelectionCard):
	select_character(unit)
	ui_battle.mini_card_select(card)


func select_character(unit:Character):
	#Disconnect main unit card signal from a Selected Character if there is one
	if battle_data.selected_character:
		if battle_data.selected_character.on_stat_changed.is_connected(ui_battle.ui_unit_card._update_label):
			battle_data.selected_character.on_stat_changed.disconnect(ui_battle.ui_unit_card._update_label)
	
	#Select Character and Make Active
	battle_data.selected_character = unit
	battle_data.active_character = unit
	
	battle_data.selected_character.on_stat_changed.connect(ui_battle.ui_unit_cards.update_all_unit_cards)
	ui_battle.on_character_selected(unit,self)
	drawing_battle.draw_box.visible = true
	drawing_battle.draw_box.position = unit.position
	
func update_unit_ui(value_name:String,value):
	ui_battle.ui_unit_card._update_info(value_name,value)


func start_faction_turn():
	if battle_data.active_faction == "Player":
		print("Player's turn!")
	else:
		print("AI's turn!")
		#battle_data.active_factions_units[battle_data.active_faction] = ai_registry.get_faction_units(battle_data.factions_in_battle[battle_data.active_faction_index])
		start_ai_unit_turn()


func faction_turn_finished():
	if battle_data.factions_in_battle.size() <= 0:
		return
	#Set the turn for the next faction
	battle_data.active_faction_index = (battle_data.active_faction_index + 1) % battle_data.factions_in_battle.size()
	start_faction_turn()


func start_ai_unit_turn():
	battle_data.active_character = battle_data.active_factions_units[battle_data.active_faction][battle_data.active_ai_char_index]
	#ai_decision_maker.start_decisions(battle_data.active_character)
	pass


func finish_ai_unit_turn():
	if battle_data.active_ai_char_index + 1 >= battle_data.active_factions_units[battle_data.active_faction].size():
		battle_data.active_ai_char_index = 0
		faction_turn_finished()
		return
	battle_data.active_ai_char_index+=1
	start_ai_unit_turn()


func character_finished_move_section(unit:Character):
	GridService.update_char_moved_data(unit,battle_data.grid)
	path_finder.set_cell_free_from_vector2(unit.char_last_cell_pos)
	path_finder.set_blocked_cell_from_vector2(unit.position)
