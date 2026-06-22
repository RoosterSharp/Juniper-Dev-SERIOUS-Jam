extends Resource
class_name Bullet

@export var type : StringName
@export var texture : Texture2D
@export var heat := 5.0
@export var effects : Array[BulletEffect]

func fire():
	for effect in effects:
		await effect.apply()
