extends Label

func _process(_delta):
	text = "Score: %s" % Cylinder.get_instance().score
