extends Resource
class_name Bullet

@export var type : String
@export var colour : String #hex code
@export var damage := 5
@export var healing := 0

func shoot_bullet() -> int:
	return -damage+healing
