class_name Gun
extends Node2D

static var _node : Gun
@onready var animator: AnimationPlayer = $AnimationPlayer

func _init():
	_node = self

static func get_instance() -> Gun:
	return _node

func shoot():
	animator.play("shoot")
