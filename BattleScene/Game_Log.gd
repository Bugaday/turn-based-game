extends VBoxContainer

class_name GameLog
	
func log(text: String):
	# Log simply spawns a new label in the log and scrolls to it. Great for seeing what's happening.
	var label = Label.new()
	label.text = text
	add_child(label)
