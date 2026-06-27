class_name BEEffect
extends BulletEffect

@export var effect_name : StringName

# in shots
@export var duration := 1

func apply():
	if do_multiply:
		Character.get_instance().add_effect(effect_name,duration*2)
	else:
		Character.get_instance().add_effect(effect_name,duration)

func _to_string() -> String:
	return "Apply the %s effect for %s shots" % [str(effect_name), str(duration)]
