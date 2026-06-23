class_name Cylinder
extends Node

signal chamber_updated(idx : int, new_value)

const HEAT_DROP_RATE = 20
const EMPTY = preload("res://bullets/empty.tres")

static var _node

@export var chambers_num := 6
@export var heat_color_ramp : Gradient

var char_ref
@export var deck : Array[Bullet]
var bullets : Array[Bullet]
var heat := 0.0
var max_heat = 100.0

@onready var shoot_timer = $ShootTimer

func _init() -> void:
	_node = self

func _ready() -> void:
	change_size(chambers_num)
	char_ref = Character.get_instance()

func _process(delta: float) -> void:
	heat = move_toward(heat, 0, delta*HEAT_DROP_RATE)
	disp_heat()


static func get_instance() -> Cylinder:
	return _node


func shoot_rand():
	if is_empty():
		return
	
	shoot_timer.stop()
	var options = []
	for i in chambers_num:
		if bullets[i] != EMPTY:
			options.push_back(i)
	
	var selected = options.pick_random()
	var cylinder_sprite = DynamicCylinder.get_instance()
	
	cylinder_sprite.set_input_enabled(false)
	var spin_dir = (randi()%2)*2-1 # random either 1 or -1
	var tween = create_tween()
	cylinder_sprite.rotation = wrapf(cylinder_sprite.rotation,0,2*PI)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(cylinder_sprite,"rotation",-2.0*PI*selected/chambers_num+6*PI * spin_dir ,1.5)
	await tween.finished
	cylinder_sprite.set_input_enabled(true)
	DynamicCylinder.get_instance().selected_chamber = selected
	shoot()


func shoot():
	shoot_timer.stop()
	
	var selected_chamber = DynamicCylinder.get_instance().selected_chamber
	var i = selected_chamber
	
	#while bullets[i] == EMPTY:
		#i += 1
		#if i >= chambers_num:
			#i = 0
		#if i == selected_chamber:
			#return
	
	var bullet = bullets[i]
	
	if bullet == Bullet.EMPTY:
		return
	
	bullet.fire()
	set_chamber(i, EMPTY)
	
	Character.get_instance().deplete_effects()
	
	if heat <= max_heat - 20:
		heat += bullet.heat
	else:
		heat = 100.0
	
	shoot_timer.start()


func fill_cylinder():
	var chambers = DynamicCylinder.get_instance().num_slots
	for chamber in chambers:
		if bullets[chamber] == EMPTY:
			set_chamber(chamber, rand_bullet())
	shoot_timer.start()


func is_empty() -> bool:
	return bullets.all(func(b): return b == Bullet.EMPTY)


func disp_heat():
	var cyl_image = DynamicCylinder.get_instance()
	var heat_percentage = heat/100.0 #gets a percentage value of heat level
	heat_percentage = clamp(heat_percentage,-100,100)
	cyl_image.set_modulate(heat_color_ramp.sample(0.5+heat_percentage*0.5))


func rand_bullet() -> Bullet:
	return Bullet.rand_from(deck)


func set_chamber(idx : int, bullet : Bullet):
	bullets[idx] = bullet
	chamber_updated.emit(idx, bullet)


func change_size(new_size: int):
	DynamicCylinder.get_instance().set_num_slots(new_size)
	bullets.resize(new_size)
	for i in new_size:
		if bullets[i] == null:
			bullets[i] = EMPTY


static func get_bullets() -> Array[Bullet]:
	return _node.bullets.duplicate()
