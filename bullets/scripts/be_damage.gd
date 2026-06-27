class_name BEDamage
extends BulletEffect

@export var amount := 5

func apply():
	if do_multiply:
		Character.get_instance().damage(amount*multiplier)
	else:
		Character.get_instance().damage(amount)

func _to_string() -> String:
	return "Deal %s damage" % amount
