extends RichTextLabel

class_name GameLog

	
func log(log_text: String):
	append_text(log_text)
	newline()
