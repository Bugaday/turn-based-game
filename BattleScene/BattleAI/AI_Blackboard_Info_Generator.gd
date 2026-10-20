class_name AIBlackboardInfoGenerator
extends RefCounted



#static func update_all_info(unit:Character,ai_registry:AIRegistry)->AIBlackboard:
	#ai_registry.unit_blackboards[unit].set_value("Enemies",get_all_enemy_characters(unit,ai_registry))
	#ai_registry.unit_blackboards[unit].set_value("Enemies_in_Range",get_all_enemy_characters(unit,ai_registry))


static func get_all_enemy_characters(unit:Character,ai_registry:AIRegistry)->Array[Character]:
	var current_unit_faction : String = unit.faction
	var enemies : Array[Character]
	for faction : String in ai_registry.faction_blackboards.keys():
		if faction != current_unit_faction:
			for c : Character in ai_registry.faction_unit_mappings[faction]:
				enemies.append(c)
	return enemies


static func enemies_in_range(unit:Character,ai_registry:AIRegistry)->Array[Character]:
	var enemiesInRange : Array[Character]
	for enemy : Character in ai_registry.unit_blackboards[unit].get_value("Enemies"):
		var unit_grid_pos : Vector2i = GridService.world_to_grid(unit.position)
		var enemy_grid_pos : Vector2i = GridService.world_to_grid(enemy.position)
		if enemy_grid_pos.distance_to(unit_grid_pos) <= float(unit.base_stats.class_weapon.weapon_range):
			enemiesInRange.append(enemy)
	return enemiesInRange


static func get_closest_enemy(unit:Character,ai_registry:AIRegistry)->Character:
	var enemiesInRange : Array[Character] = ai_registry.unit_blackboards[unit].get_value("Enemies")
	if enemiesInRange.size() <= 0:
		return
	var closest_enemy : Character = enemiesInRange[0]
	for enemy in enemiesInRange:
		if enemy.position.distance_to(unit.position) < closest_enemy.position.distance_to(unit.position):
			closest_enemy = enemy
	return closest_enemy
