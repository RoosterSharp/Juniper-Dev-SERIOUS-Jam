extends Node2D
class_name Character

@export var base_health := 20
@export var chambers_num := 6

var health : int
var heat := 0.0
var max_heat = 100.0
var heat_drop_value := 5.0
var heat_drop_timer := 30#frames
const heat_drop_time = 30 
var shot_frequency := 300 
var shot_time := 0 #since last shot
var selected_chamber : int
static var _node
var cyl_ref

func _init():
	_node = self

static func get_instance() -> Character:
	return _node

func _ready():
	health = base_health
	cyl_ref = Cylinder.get_instance()

func _process(_delta):
	tick()

func tick():
	if shot_time < shot_frequency:
		shot_time += 1
	else:
		cyl_ref.shoot()
		shot_time = 0
	
	if heat > 0:
		if heat_drop_timer > 0:
			heat_drop_timer -= 1
		else:
			if heat >= heat_drop_value:
				heat -= heat_drop_value
				cyl_ref.disp_heat()
			else: if heat > 0:
				heat = 0
			heat_drop_timer = heat_drop_time
			print(heat)
