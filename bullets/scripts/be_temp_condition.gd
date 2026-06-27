class_name BECHeat
extends BEConditional

const SYMBOLS = [">","<","="]

@export_enum(">","<","=") var conditional_type = 0
@export var heat_level := 0



func check_condition():
	match conditional_type:
		0:
			if Cylinder.get_instance().heat > heat_level:
				return true
		1:
			if Cylinder.get_instance().heat < heat_level:
				return true
		2:
			if Cylinder.get_instance().heat == heat_level:
				return true
	return false

func _to_string() -> String:
	var output = "if heat %s %s:" % [SYMBOLS[conditional_type],str(heat_level)]
	for e in effects:
		output += "\n   "+str(e)
	return output
