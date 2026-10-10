extends Node2D

class_name SceneBattle

static var battle_data : BattleData
@export var path_finder : Pathfinder2D
@export var drawing_battle : Drawing
@export var ui_battle : UIBattle
@export var command_processor : CommandProcessor

var ai_decision_maker : AIDecisionMaker = AIDecisionMaker.new()

var current_state : StateGame

func _ready() -> void:
	
	#Autoload
	DebugVis.battle = self
	
	#Initialise Static Variables
	StateMachineHover.scene_battle = self
	StateMachineHover.drawing = drawing_battle
	StateMachineHover.ui_battle = ui_battle
	
	CreateGrid()
	battle_data.battle_spawner.new_character_spawned.connect(character_spawned)
	battle_data.setup(path_finder,ui_battle)
	battle_data.on_character_hovered.connect(ui_battle.on_character_hovered)
	battle_data.on_character_unhovered.connect(ui_battle.on_character_unhovered)
	for c in battle_data.all_characters:
		var card : UIUnitCardMini = ui_battle.ui_unit_cards.ui_unit_mini_cards_group.get_card_by_character(c)
		card.card_character_hovered.connect(mini_card_hovered)
	DebugVis.update_blocked_positions()

	
func character_spawned(unit:Character):
	ui_battle.on_character_spawned(unit,self)


func mini_card_hovered(unit:Character):
	#drawing_battle.cursor.visible = true
	#drawing_battle.cursor.position = GridService.snap_pos_to_grid(unit.position)
	print("Card hovered")


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


func mini_card_selected(unit:Character,card:UIUnitCardMini):
	select_character(unit)
	ui_battle.mini_card_select(card)


func select_character(unit:Character):
	if battle_data.selected_character:
		var old_char : Character = battle_data.selected_character
		if old_char.on_stat_changed.is_connected(ui_battle.ui_unit_cards.ui_unit_card_main.update_all_values):
			old_char.on_stat_changed.disconnect(ui_battle.ui_unit_cards.ui_unit_card_main.update_all_values)
	#Select Character and Make Active
	battle_data.selected_character = unit
	battle_data.selected_character.on_stat_changed.connect(ui_battle.ui_unit_cards.ui_unit_card_main.update_all_values)
	battle_data.active_character = unit
	ui_battle.on_character_selected(unit,self)
	drawing_battle.draw_box.visible = true
	drawing_battle.draw_box.position = unit.position
	StaticTest.do_static_things(battle_data.selected_character)


func update_unit_ui(value_name:String,value):
	ui_battle.ui_unit_card._update_info(value_name,value)


static func start_faction_turn():
	if battle_data.active_faction == "Player":
		print("Player's turn!")
	else:
		print("AI's turn!")
		#battle_data.active_factions_units[battle_data.active_faction] = ai_registry.get_faction_units(battle_data.factions_in_battle[battle_data.active_faction_index])
		start_ai_unit_turn()


static func faction_turn_finished():
	if battle_data.factions_in_battle.size() <= 0:
		return
	#Set the turn for the next faction
	battle_data.active_faction_index = (battle_data.active_faction_index + 1) % battle_data.factions_in_battle.size()
	start_faction_turn()


static func end_turn():
	print("Turn ended")
	faction_turn_finished()
	pass


static func start_ai_unit_turn():
	battle_data.active_character = battle_data.active_factions_units[battle_data.active_faction][battle_data.active_ai_char_index]
	print("Starting AI unit's turn")
	ai_decision_maker.start_decisions(battle_data.active_character)
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
