extends Node

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
			get_window().mode = Window.MODE_MAXIMIZED
		else:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
