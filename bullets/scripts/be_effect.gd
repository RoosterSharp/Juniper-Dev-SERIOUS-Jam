class_name BEEffect
extends BulletEffect

@export var effect_name : StringName

# in shots
@export var duration := 1

func apply():
	char_ref.add_effect(effect_name,duration)
