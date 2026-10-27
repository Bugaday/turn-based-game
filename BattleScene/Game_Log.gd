extends RichTextLabel

class_name GameLog

	
func log(text: String):
	append_text(text)
	newline()
