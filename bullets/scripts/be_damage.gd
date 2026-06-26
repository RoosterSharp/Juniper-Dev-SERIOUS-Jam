class_name BEDamage
extends BulletEffect

@export var amount := 5

func apply():
	Character.get_instance().damage(amount)
