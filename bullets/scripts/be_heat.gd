class_name BEHeat
extends BulletEffect

@export var amount := 0

func apply():
	Cylinder.get_instance().heat += amount
	Cylinder.get_instance().disp_heat()

func _to_string() -> String:
	return "heat " + (("+"+str(amount)) if amount >= 0 else str(amount))
