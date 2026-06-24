class_name BEHeal
extends BulletEffect

@export var amount := 5

func apply():
	Character.get_instance().heal(amount)
