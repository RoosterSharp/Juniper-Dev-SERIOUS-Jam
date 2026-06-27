class_name BulletEffect
extends Resource

static var multiplier := 2.0
static var do_multiply = false

func apply():
	pass 

func _to_string() -> String:
	return "Bro this class is abstract what you doing"

static func reset_multiplier():
	multiplier = 2.0
	do_multiply = false
