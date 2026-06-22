class_name Cylinder
extends Node

signal chamber_updated(idx : int, new_value)

const EMPTY = preload("res://bullets/empty.tres")

static var _node

var char_ref

var bullets : Array[Bullet]


func _init() -> void:
	_node = self

func _ready() -> void:
	bullets.resize(DynamicCylinder.get_instance().num_slots)
	for i in bullets.size():
		set_chamber(i, EMPTY)
	char_ref = Character.get_instance()

static func get_instance() -> Cylinder:
	return _node

func shoot():
	var selected_chamber = DynamicCylinder.get_instance().selected_chamber
	var i = selected_chamber
	while bullets[i] == EMPTY:
		i += 1
		if i >= char_ref.chambers_num:
			i = 0
		if i == selected_chamber:
			return
	
	bullets[i].fire()
	set_chamber(i, EMPTY)
	if char_ref.heat <= char_ref.max_heat - 20:
		char_ref.heat += 20
	else:
		char_ref.heat = 100.0
	disp_heat()
	char_ref.shot_time = 0

func fill_cylinder():
	var new_arr : Array[Bullet]
	var chambers = DynamicCylinder.get_instance().num_slots
	for chamber in chambers:
		if bullets[chamber] == EMPTY:
			set_chamber(chamber, rand_bullet())
	char_ref.shot_time = 0
	return new_arr

func disp_heat():
	var cyl_image = DynamicCylinder.get_instance()
	var heat_col = 1-char_ref.heat/100 #gets a percentage value of heat level
	if heat_col < 0:
		heat_col = 0
	cyl_image.set_modulate(Color(1,heat_col,heat_col))

func rand_bullet() -> Bullet:
	return preload("res://bullets/basic.tres")

func set_chamber(idx : int, bullet : Bullet):
	bullets[idx] = bullet
	chamber_updated.emit(idx, bullet)

func change_size(new_size: int):
	DynamicCylinder.get_instance().set_num_slots(new_size)

static func get_bullets() -> Array[Bullet]:
	return _node.bullets.duplicate()
