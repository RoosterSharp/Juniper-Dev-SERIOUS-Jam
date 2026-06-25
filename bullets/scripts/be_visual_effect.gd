class_name BEVisualEffect
extends BulletEffect

@export var effect_name : StringName

func apply():
	Character.get_instance().visual_effect(effect_name)
