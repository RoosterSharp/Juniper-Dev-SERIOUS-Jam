class_name BEHeal
extends BulletEffect

@export var amount := 5

func apply():
	char_ref.heal(amount)
