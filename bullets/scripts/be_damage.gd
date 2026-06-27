class_name BEDamage
extends BulletEffect

@export var amount := 5

func apply():
	if double:
		Character.get_instance().damage(amount*2)
	else:
		Character.get_instance().damage(amount)
