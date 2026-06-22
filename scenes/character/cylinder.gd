class_name Cylinder
extends Node

signal chamber_updated(idx : int, new_value)

const EMPTY = preload("res://bullets/empty.tres")

static var _node

var bullets : Array[Bullet]


func _init() -> void:
	_node = self

func _ready() -> void:
	bullets.resize(DynamicCylinder.get_instance().num_slots)
	bullets.fill(EMPTY)

static func get_instance() -> Cylinder:
	return _node

func shoot():
	
	var selected_chamber = DynamicCylinder.get_instance().selected_chamber
	if bullets[selected_chamber] == EMPTY:
		return
	
	bullets[selected_chamber].fire()
	set_chamber(selected_chamber, EMPTY)

func fill_cylinder():
	var new_arr : Array[Bullet]
	var chambers = DynamicCylinder.get_instance().num_slots
	for chamber in chambers:
		if bullets[chamber] == EMPTY:
			set_chamber(chamber, rand_bullet())
	return new_arr

func rand_bullet() -> Bullet:
	return preload("res://bullets/normal.tres")

func set_chamber(idx : int, bullet : Bullet):
	bullets[idx] = bullet
	chamber_updated.emit(idx, bullet)

func change_size(new_size: int):
	DynamicCylinder.get_instance().set_num_slots(new_size)

static func get_bullets() -> Array[Bullet]:
	return _node.bullets.duplicate()
