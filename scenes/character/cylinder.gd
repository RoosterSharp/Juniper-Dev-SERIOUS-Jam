class_name Cylinder
extends Node

signal chamber_updated(idx : int, new_value)

const HEAT_DROP_RATE = 20
const EMPTY = preload("res://bullets/empty.tres")

static var _node

@export var chambers_num := 6
@export var heat_color_ramp : Gradient

var shot_frequency := 300
var shot_time := 0 #since last shot
var char_ref
var deck : Array[Bullet]
var bullets : Array[Bullet]
var heat := 0.0
var max_heat = 100.0

func _init() -> void:
	_node = self
	deck.append(preload("res://bullets/basic.tres"))
	deck.append(preload("res://bullets/heal.tres"))
	deck.append(preload("res://bullets/cold.tres"))

func _ready() -> void:
	bullets.resize(DynamicCylinder.get_instance().num_slots)
	for i in bullets.size():
		set_chamber(i, EMPTY)
	char_ref = Character.get_instance()

func _process(delta: float) -> void:
	heat = move_toward(heat, 0, delta*HEAT_DROP_RATE)
	
	disp_heat()
	
	if shot_time < shot_frequency:
		shot_time += 1
	else:
		shoot_rand()
		shot_time = 0
	print(heat)


static func get_instance() -> Cylinder:
	return _node


func shoot_rand():
	var options = []
	for i in chambers_num:
		if bullets[i] != EMPTY:
			options.push_back(i)
	
	if options.size() == 0:
		return
	
	var selected = options.pick_random()
	var cylinder_sprite = DynamicCylinder.get_instance()
	
	cylinder_sprite.set_input_enabled(false)
	var spin_dir = (randi()%2)*2-1 # random either 1 or -1
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(cylinder_sprite,"rotation",-2.0*PI*selected/chambers_num+6*PI * spin_dir ,2.0)
	await tween.finished
	cylinder_sprite.rotation = wrapf(cylinder_sprite.rotation,0,2*PI)
	cylinder_sprite.set_input_enabled(true)
	DynamicCylinder.get_instance().selected_chamber = selected
	shoot()


func shoot():
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
	if heat <= max_heat - 20:
		heat += bullet.heat
	else:
		heat = 100.0
	
	shot_time = 0


func fill_cylinder():
	var new_arr : Array[Bullet]
	var chambers = DynamicCylinder.get_instance().num_slots
	for chamber in chambers:
		if bullets[chamber] == EMPTY:
			set_chamber(chamber, rand_bullet())
	shot_time = 0
	return new_arr


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
