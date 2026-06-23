class_name ChamberButton
extends Node2D

const EMPTY = preload("res://bullets/empty.tres")

signal button_pressed

@onready var texture_button: TextureButton = $Node/Node2D/TextureButton
@onready var sprite_2d: Sprite2D = $Node/Node2D/Sprite2D

var button_idx := 0

func _ready() -> void:
	texture_button.button_down.connect(_button_down)
	sprite_2d.texture = EMPTY.texture
	Cylinder.get_instance().chamber_updated.connect(_chamber_updated)

func _button_down():
	button_pressed.emit(button_idx)

func _chamber_updated(idx, bullet):
	if button_idx != idx:
		return
		
	if bullet:
		sprite_2d.texture = bullet.texture
	else:
		sprite_2d.texture = null
	
	texture_button.visible = bullet != Bullet.EMPTY
