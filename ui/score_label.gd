extends Label

func _process(delta):
	text = "Score: %s" % Cylinder.get_instance().score
