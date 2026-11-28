class_name AIDataPrep

extends RefCounted


static func normalise_values(val:float,min:float,max:float)->float:
	var clamped_value : float = clampf(val,min,max)
	var normalised_value = val / (max-min)
	return normalised_value


static func current_unit_health(unit:Character)-> float:
	var health = unit.health_current
	var n_health = normalise_values(health,0.0,unit.base_stats.health)
	print("Normalised health: ",n_health)
	return n_health


static func enemies_in_range(unit:Character,battle_scene:SceneBattle)->float:
	var enemies_in_range : Array[Character] = AIBlackboardInfoGenerator.enemies_in_range(unit,battle_scene.battle_data.ai_registry)
	var enemies : float = float(enemies_in_range.size())
	var n_val = normalise_values(enemies,0.0,3.0)
	print("Normalised enemies in range: ",n_val)
	return n_val
