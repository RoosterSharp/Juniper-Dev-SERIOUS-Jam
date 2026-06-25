class_name BEDamage
extends BulletEffect

@export var amount := 5

func apply():
	char_ref.damage(amount)
