extends Node2D
class_name Character

@export var base_health := 20
@export var chambers := 6

var health : int
var heat := 0.0
#var max_heat
var shot_frequency := 240 #frames
var shot_time := 0 #since last shot
var bullets : Array[Bullet]
var deck : Array[Bullet]
var selected_chamber : int
static var _node

@onready var cylinder: Node2D = $"../DynamicCylinder"

func _init():
	_node = self

func _ready():
	health = base_health
	deck.resize(1)
	deck[0] = Bullet.new()
	bullets.resize(chambers)
	bullets = fill_cylinder(bullets)

func shoot():
	health -= bullets[selected_chamber].shoot_bullet()
	bullets[selected_chamber] = null

func fill_cylinder(input_arr: Array[Bullet]) -> Array[Bullet]:
	var new_arr : Array[Bullet]
	new_arr.resize(chambers)
	for chamber in chambers:
		if input_arr[chamber] != null:
			new_arr[chamber] = input_arr[chamber]
		else:
			new_arr[chamber] = rand_bullet()
	return new_arr

func rand_bullet() -> Bullet:
	var new_bullet = deck.pick_random()
	return new_bullet

func change_size(new_size: int):
	chambers = new_size
	cylinder.set_num_slots(new_size)
