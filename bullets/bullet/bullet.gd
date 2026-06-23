extends Resource
class_name Bullet

const EMPTY = preload("res://bullets/empty.tres")

@export var type : StringName
@export var texture : Texture2D
@export var heat := 5.0
@export var rarity := 1.0
@export var effects : Array[BulletEffect]


func fire():
	for effect in effects:
		await effect.apply()

static func rand_from(bullets):
	var rng = RandomNumberGenerator.new()
	var weights = []
	
	for b in bullets:
		weights.append(1.0/b.rarity)
	
	return bullets[rng.rand_weighted(weights)]
