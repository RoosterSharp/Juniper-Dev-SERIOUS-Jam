extends Resource
class_name Bullet

const EMPTY = preload("res://bullets/empty.tres")
const BULLET_PATH = "res://bullets/bullet_resources/"

static var _bullet_list = null

@export var type : StringName
@export var texture : Texture2D
@export var heat := 5.0
@export var weight := 1.0
@export var effects : Array[BulletEffect]


static func get_bullet_list():
	if !_bullet_list:
		_bullet_list = []
		var files = DirAccess.get_files_at(BULLET_PATH)
		for file in files:
			_bullet_list.append(load(BULLET_PATH+file))
	return _bullet_list.duplicate()


func fire():
	for effect in effects:
		await effect.apply()


static func rand_from(bullets):
	var rng = RandomNumberGenerator.new()
	var weights = []
	
	for b in bullets:
		weights.append(b.weight)
	
	return bullets[rng.rand_weighted(weights)]
