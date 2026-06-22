extends Node2D
class_name Character

@export var base_health := 20
@export var chambers := 6

var health : int
var heat := 0.0
#var max_heat
var shot_frequency := 240 #frames
var shot_time := 0 #since last shot
var selected_chamber : int
static var _node


func _init():
	_node = self

func _ready():
	health = base_health
