extends Node2D

func _ready():
	for button in $Buttons.get_children():
		button.pressed.connect(button_pressed.bind(button.get_meta("num")))

func button_pressed(num: int):
	print("pressed " + str(num))
