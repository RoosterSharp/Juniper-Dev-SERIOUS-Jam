class_name ChamberButton
extends Node2D

signal button_pressed

@onready var texture_button: TextureButton = $Node/Node2D/TextureButton

var button_idx := 0

func _ready() -> void:
	texture_button.button_down.connect(_button_down)
	Cylinder.get_instance().chamber_updated.connect(_chamber_updated)

func _button_down():
	button_pressed.emit(button_idx)

func _chamber_updated(idx, bullet):
	if button_idx != idx:
		return
	print("test")
	if bullet:
		texture_button.texture_normal = bullet.texture
	else:
		texture_button.texture_normal = null
