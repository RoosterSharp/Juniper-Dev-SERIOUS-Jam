extends Node2D
class_name Character

const DEAD_TEXT = """You LOSE!
		Final Score: %s"""

static var _node

@onready var heart: TextureProgressBar = $Heart

@export var health := 20

var max_health := 20
var cyl_ref
var effects = {}
var dead = false
@onready var dead_dialog = $DeadDialog
@onready var heart_sprite_timer: Timer = $HeartSpriteTimer
@onready var dead_sound: AudioStreamPlayer = $DeadSound


func _init():
	_node = self


static func get_instance() -> Character:
	return _node

func _ready():
	Cylinder.get_instance().emptied.connect(reset)

func reset():
	health = max_health
	disp_health()

func add_effect(effect_name : StringName, duration : int):
	duration += 1 # adding 1 so that it lasts past this turn
	
	# if you already have the effect and with a higher duration, do nothing
	if effects.keys().has(effect_name):
		if effects[effect_name] < duration:
			effects.merge({effect_name : duration},true)
	else:
		effects.merge({effect_name : duration})


func has_effect(effect_name : StringName) -> bool:
	return effects.keys().has(effect_name)

# depletes the remaining turn count of effects
func deplete_effects():
	var keys = effects.keys()
	for key in keys:
		effects[key] -= 1
		if effects[key] <= 0:
			effects.erase(key)


func damage(amt : int):
	if has_effect(&"guard"):
		return
	health = max(health - amt, 0)
	
	disp_health()
	
	if health == 0:
		die()


func heal(amt : int):
	health = min(max_health, health+amt)
	disp_health()

func die():
	dead_sound.play()
	dead = true
	get_tree().paused = true
	dead_dialog.dialog_text = DEAD_TEXT % Cylinder.get_instance().score
	dead_dialog.show()
	await dead_dialog.confirmed
	BulletEffect.reset_multiplier()
	get_tree().paused = false
	get_tree().reload_current_scene()

func disp_health():
	heart.value = float(health)/float(max_health) * 100.0

func bullet_effect(effect: StringName):
	heart.texture_under = load("res://assets/hearts/" + effect + "HeartBottom.png")
	heart.texture_progress = load("res://assets/hearts/" + effect + "HeartTop.png")
	heart_sprite_timer.start()

func visual_effect(effect_name : StringName):
	match effect_name:
		&"whatever_the_effect_name_is":
			pass # do stuff

func _reset_heart_sprite():
	bullet_effect(&"normal")
