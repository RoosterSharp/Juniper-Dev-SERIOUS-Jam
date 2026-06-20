extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

const spin_frequency := 1 #frames
var spin_timer := 0
const spin_amount := 15 #degrees

func _process(delta):
	tick()
	
func tick():
	if spin_timer >= 0:
		spin_timer -= 1
	else:
		rotate_sprite()
		spin_timer = spin_frequency

func rotate_sprite():
	sprite.rotate(deg_to_rad(spin_amount))
