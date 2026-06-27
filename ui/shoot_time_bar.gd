extends ProgressBar

func _process(_delta):
	max_value = Cylinder.get_instance().shoot_timer.wait_time
	value = Cylinder.get_instance().shoot_timer.time_left
