class_name BEHeal
extends BulletEffect

@export var amount := 5

func apply():
	if do_multiply:
		Character.get_instance().heal(amount*multiplier)
	else:
		Character.get_instance().heal(amount)

func _to_string() -> String:
	return "heals %s health" % amount
