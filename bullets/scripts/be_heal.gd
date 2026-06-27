class_name BEHeal
extends BulletEffect

@export var amount := 5

func apply():
	if double:
		Character.get_instance().heal(amount*2)
	else:
		Character.get_instance().heal(amount)
