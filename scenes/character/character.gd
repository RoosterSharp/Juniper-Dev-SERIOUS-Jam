extends Node2D
class_name Character

const HEAT_DROP_RATE = 20

static var _node

@export var base_health := 20
@export var chambers_num := 6


var health : int
var heat := 0.0
var max_heat = 100.0

var cyl_ref

func _init():
	_node = self

static func get_instance() -> Character:
	return _node

func _ready():
	health = base_health
	cyl_ref = Cylinder.get_instance()
	cyl_ref.change_size(chambers_num)

func _process(delta):
	
	heat = move_toward(heat, 0, delta*HEAT_DROP_RATE)
	


func damage(amt : int):
	health = max(health - amt, 0)

func heal(amt : int):
	health += amt
