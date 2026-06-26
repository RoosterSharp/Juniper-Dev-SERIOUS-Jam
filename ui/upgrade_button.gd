extends Button

signal button_pressed_idx(idx : int)

@export var button_idx := 0

@onready var benifit: VBoxContainer = $VBoxContainer/Benifit
@onready var drawback: VBoxContainer = $VBoxContainer/Drawback



func _pressed() -> void:
	button_pressed_idx.emit(button_idx)



func set_benifit(title : String, description : String, tex : Texture2D):
	benifit.set_info(title, description, tex)

func set_drawback(title : String, description : String, tex : Texture2D):
	drawback.set_info(title, description, tex)
