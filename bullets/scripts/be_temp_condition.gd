class_name BECHeat
extends BEConditional

@export_enum(">","<","==") var conditional_type = 0
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
