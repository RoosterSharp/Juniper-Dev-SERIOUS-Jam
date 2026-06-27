class_name UpgradeEffect
extends Resource

## Not really needed if its just a bullet
@export var id : String
@export var texture : Texture2D
## Not really needed if its just a bullet
@export var display_name : String
## Not really needed if its just a bullet
@export_multiline var description : String

## only if this upgrade gives you a bullet
@export var bullet : Bullet 

func get_texture():
	if bullet:
		return bullet.texture
	else:
		return texture

func get_title():
	if bullet:
		return bullet.display_name
	else:
		return display_name

func get_description():
	if bullet:
		return bullet.get_description()
	else:
		return description

func apply():
	if bullet:
		Cylinder.get_instance().add_bullet(bullet)
	else:
		match id:
			"less_time":
				var timer = Cylinder.get_instance().shoot_timer
				timer.wait_time *= 0.9
