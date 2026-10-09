extends Node2D

class_name StateMachineHover

static var current_hover_state : StateHover
static var scene_battle : SceneBattle
static var drawing : Drawing
static var ui_battle : UIBattle

static var possible_states : Array[StateHover]

static var HoverStateNone : StateHoverNone
static var HoverStateGrid : StateHoverGrid
static var HoverStateCharacter : StateHoverCharacter
static var HoverStateMiniCard : StateHoverMiniCard

func _ready() -> void:
	HoverStateNone = StateHoverNone.new()
	HoverStateGrid = StateHoverGrid.new()
	HoverStateCharacter = StateHoverCharacter.new()
	HoverStateMiniCard  = StateHoverMiniCard.new()
	change_state_hover(HoverStateNone)


func _process(_delta: float) -> void:
	if current_hover_state:
		current_hover_state.Update(_delta,scene_battle,drawing,ui_battle)


static func change_state_hover(newStateHover : StateHover):
	#Check if state name exists
	if current_hover_state:
		current_hover_state._exit_state(scene_battle,drawing,ui_battle)
	current_hover_state = newStateHover
	print("New state is: ",newStateHover.get_script().get_global_name())
	#newStateHover.on_hover_state_change.connect(change_state_hover,CONNECT_ONE_SHOT)
	current_hover_state._enter_state(scene_battle,drawing,ui_battle)
