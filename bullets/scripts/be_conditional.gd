class_name BEConditional
extends BulletEffect

@export var effects : Array[BulletEffect]

func apply():
	if check_condition():
		for e in effects:
			e.apply()

func check_condition():
	pass
