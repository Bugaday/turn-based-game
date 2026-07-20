extends Object

class_name Debug

static func log(msg:String,clr:Color=Color.GREEN):
	# .to_html() converts the Color object to a hex string like "9370db"
	print_rich("[color=#%s][b]%s[/b][/color]" % [clr.to_html(false), msg])
