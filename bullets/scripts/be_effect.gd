class_name BEEffect
extends BulletEffect

@export var effect_name : StringName

# in shots
@export var duration := 1

func apply():
	if double:
		Character.get_instance().add_effect(effect_name,duration*2)
	else:
		Character.get_instance().add_effect(effect_name,duration)
