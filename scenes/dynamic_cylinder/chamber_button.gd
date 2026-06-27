class_name ChamberButton
extends Node2D

signal button_pressed

static var show_tooltip = false

@onready var texture_button: TextureButton = $Node/Node2D/TextureButton
@onready var sprite_2d: Sprite2D = $Node/Node2D/Sprite2D

var button_idx := 0


func _ready() -> void:
	texture_button.button_down.connect(_button_down)
	sprite_2d.texture = Bullet.get_empty().texture
	Cylinder.get_instance().chamber_updated.connect(_chamber_updated)
	texture_button.visible = false

func _button_down():
	button_pressed.emit(button_idx)

func _chamber_updated(idx, bullet):
	if button_idx != idx:
		return
		
	if bullet:
		sprite_2d.texture = bullet.texture
		if show_tooltip && bullet != Bullet.get_empty():
			texture_button.tooltip_text = bullet.get_description_with_title()+"\nNumber owned: %s" % str(Cylinder.get_instance().get_count_in_deck(bullet))
			texture_button.visible = true
		else:
			texture_button.tooltip_text = ""
			texture_button.visible = false
	else:
		sprite_2d.texture = null
	
	#texture_button.visible = bullet != Bullet.get_empty()
