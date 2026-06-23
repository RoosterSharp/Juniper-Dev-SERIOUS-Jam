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


func heal(amt : int):
	health += amt
