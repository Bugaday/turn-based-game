extends ActionCommand

class_name ActionCommandMove

var move_tween : Tween

func _init(src:Character,tar) -> void:
	super(src,tar)
	
	source_char.moveTargets.append(target)
	#scene_data.drawing.draw_move_line(current_char,target)


func start_action():
	start_finished.emit()


func execute_action():
	super()
	if target is Vector2:
		var dest:Vector2 = target as Vector2
		
		move_tween = source_char.create_tween()
		move_tween.tween_property(source_char,"position",dest,1.0)
		await move_tween.finished
		print(source_char.position)
		execute_finished.emit()


func update_action():
	if move_tween.is_running():
		source_char.moveTargets[0] = source_char.position


func end_action():
	source_char.moveTargets.remove_at(1)
	action_finished.emit()
