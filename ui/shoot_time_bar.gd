extends ProgressBar

func _process(delta):
	max_value = get_parent().wait_time
	value = get_parent().time_left
