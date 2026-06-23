extends Node2D
class_name Character

static var _node

@onready var heart: TextureProgressBar = $Heart

@export var health := 20

var max_health := 20
var cyl_ref
var effects = {}

func _init():
	_node = self

func _process(delta):
	print(effects)

static func get_instance() -> Character:
	return _node

func add_effect(effect_name : StringName, duration : int):
	duration += 1 # adding 1 so that it lasts past this turn
	
	# if you already have the effect and with a higher duration, do nothing
	if effects.keys().has(effect_name):
		if effects[effect_name] < duration:
			effects.merge({effect_name : duration},true)
	else:
		effects.merge({effect_name : duration})

func has_effect(effect_name : StringName) -> bool:
	return effects.keys().has(effect_name)

# depletes the remaining turn count of effects
func deplete_effects():
	var keys = effects.keys()
	for key in keys:
		effects[key] -= 1
		if effects[key] <= 0:
			effects.erase(key)


func damage(amt : int):
	if has_effect(&"guard"):
		return
	health = max(health - amt, 0)
	disp_health()


func heal(amt : int):
	health = min(max_health, health+amt)
	disp_health()

func disp_health():
	heart.value = float(health)/float(max_health) * 100.0
