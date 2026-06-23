extends Node2D
class_name Character

static var _node

@onready var heart: TextureProgressBar = $Heart

@export var health := 20

var max_health := 20
var cyl_ref


func _init():
	_node = self


static func get_instance() -> Character:
	return _node


func damage(amt : int):
	health = max(health - amt, 0)
	disp_health()


func heal(amt : int):
	health += amt
	disp_health()

func disp_health():
	heart.value = float(health)/float(max_health) * 100.0
	print(heart.value)
