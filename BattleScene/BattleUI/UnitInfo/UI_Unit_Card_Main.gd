extends UIUnitCard

class_name UIUnitCardMain


#func _update_label(value_name:String,value):
	#if label_dict.has(value_name):
		#label_dict[value_name].text = str(value)
	#else:
		#push_error("No label value found!")
#
#
#func _update_all_labels(unit : Character):
	#unit_card_name.text = unit.base_stats.unit_name
	#unit_card_portrait.texture = unit.base_stats.sprite
	#label_dict["Health"].text = str(unit.health_.current_health)
	#label_dict["Action Points"].text = str(unit.action_points_current)
#
#
#func add_label(label_text:String)->Label:
	#if label_dict.has(label_text):
		#return
	#var new_label : Label = Label.new()
	#new_label.theme = theme_label_stats
	#new_label.add_theme_stylebox_override("normal",style_label_stats)
	#stats_current_box.add_child(new_label)
	#label_dict.set(label_text,new_label)
	#new_label.text = label_text
	#return new_label
