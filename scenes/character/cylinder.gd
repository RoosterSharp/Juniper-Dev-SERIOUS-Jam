class_name Cylinder
extends Node

signal chamber_updated(idx : int, new_value)
signal emptied
signal fired(bullet : Bullet)

const HEAT_DROP_RATE = 10

static var _node

@export var chambers_num := 6
@export var heat_color_ramp : Gradient

var char_ref
@export var deck : Array[Bullet]
@export var discard : Array[Bullet]
var obtained_bullet_list : Array[Bullet]
var bullets : Array[Bullet]
var heat := 0.0
var max_heat = 100.0
var score := 0

@onready var shoot_timer = $ShootTimer

func _init() -> void:
	_node = self

func _ready() -> void:
	change_size(chambers_num)
	char_ref = Character.get_instance()
	
	for b in deck:
		add_bullet(b,false)
	
	deck.shuffle()

func _process(delta: float) -> void:
	heat = move_toward(heat, 0, delta*HEAT_DROP_RATE)
	disp_heat()
	print(deck)


static func get_instance() -> Cylinder:
	return _node


func add_bullet(bullet : Bullet, add_to_discard = true):
	if add_to_discard:
		discard.append(bullet)
	if !obtained_bullet_list.has(bullet):
		obtained_bullet_list.append(bullet)

func shoot_rand():
	if is_empty():
		return
	
	shoot_timer.stop()
	var options = []
	for i in chambers_num:
		if bullets[i] != Bullet.EMPTY:
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
	
	var selected_chamber = DynamicCylinder.get_instance().selected_chamber
	if bullets[selected_chamber] == Bullet.EMPTY:
		return
	
	shoot_timer.stop()
	Gun.get_instance().shoot()
	
	var bullet = bullets[selected_chamber]
	
	if bullet == Bullet.EMPTY:
		return
	
	score += 1
	bullet.fire()
	fired.emit(bullet)
	discard.append(bullet)
	set_chamber(selected_chamber, Bullet.EMPTY)
	
	char_ref.deplete_effects()
	
	if heat <= max_heat - 20:
		heat += bullet.heat
	else:
		heat = 100.0
	
	shoot_timer.start()
	
	if is_empty():
		change_size(chambers_num + 1)
		emptied.emit()


func fill_cylinder():
	var chambers = DynamicCylinder.get_instance().num_slots
	for chamber in chambers:
		if bullets[chamber] == Bullet.EMPTY:
			set_chamber(chamber, rand_bullet())
	shoot_timer.start()


func clear():
	for i in chambers_num:
		set_chamber(i,Bullet.EMPTY)

func is_empty() -> bool:
	return bullets.all(func(b): return b == Bullet.EMPTY)


func refresh_chambers():
	for i in chambers_num:
		chamber_updated.emit(i,bullets[i])


func disp_heat():
	var cyl_image = DynamicCylinder.get_instance()
	var heat_percentage = heat/100.0 #gets a percentage value of heat level
	heat_percentage = clamp(heat_percentage,-100,100)
	cyl_image.set_modulate(heat_color_ramp.sample(0.5+heat_percentage*0.5))


func rand_bullet() -> Bullet:
	if deck.size() == 0:
		reshuffle()
	return deck.pop_back()


func reshuffle():
	deck.append_array(discard)
	discard.clear()
	deck.shuffle()


func set_chamber(idx : int, bullet : Bullet):
	bullets[idx] = bullet
	chamber_updated.emit(idx, bullet)


func change_size(new_size: int):
	chambers_num = new_size
	DynamicCylinder.get_instance().set_num_slots(new_size)
	bullets.resize(new_size)
	for i in new_size:
		if bullets[i] == null:
			bullets[i] = Bullet.EMPTY


func get_count_in_deck(bullet : Bullet):
	var full_deck = deck.duplicate()
	full_deck.append_array(discard)
	return full_deck.count(bullet)


static func get_bullets() -> Array[Bullet]:
	return _node.bullets.duplicate()
