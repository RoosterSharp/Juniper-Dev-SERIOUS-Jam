extends Node2D
class_name Character

const HEAT_DROP_RATE = 20

static var _node

@export var chambers_num := 6
@onready var heart: TextureProgressBar = $Heart


@export var health := 20
var max_health := 20
var heat := 0.0
var max_heat = 100.0
var shot_frequency := 300
var shot_time := 0 #since last shot
var selected_chamber : int

var cyl_ref

func _init():
	_node = self

static func get_instance() -> Character:
	return _node

func _ready():
	cyl_ref = Cylinder.get_instance()
	cyl_ref.change_size(chambers_num)

func _process(delta):
	heat = move_toward(heat, 0, delta*HEAT_DROP_RATE)
	if shot_time < shot_frequency:
		shot_time += 1
	else:
		cyl_ref.shoot()
		shot_time = 0
	@warning_ignore("integer_division")
	heart.value = health/max_health * 100

func damage(amt : int):
	health = max(health - amt, 0)

func heal(amt : int):
	health += amt
