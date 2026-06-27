class_name BEHeal
extends BulletEffect

@export var amount := 5

func apply():
	if do_multiply:
		Character.get_instance().heal(amount*int(multiplier))
	else:
		Character.get_instance().heal(amount)

func _to_string() -> String:
	return "Heals %s health" % amount
