@abstract
extends Resource

class_name AIDecision

@abstract func _get_action(unit:Character,battle_scene:SceneBattle)->ActionCommand

@abstract func _get_score(_unit:Character,battle_scene:SceneBattle) -> float
