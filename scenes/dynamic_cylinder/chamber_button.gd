class_name ChamberButton
extends Node2D

signal button_pressed

@onready var texture_button: TextureButton = $Node/Node2D/TextureButton

var button_idx := 0

func _ready() -> void:
	texture_button.button_down.connect(_button_down)

func _button_down():
	button_pressed.emit(button_idx)
