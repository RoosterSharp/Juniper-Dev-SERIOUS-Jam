extends Label

func _process(_delta: float) -> void:
	text = "Heat: %s" % (floor(Cylinder.get_instance().heat / 5.0)*5.0 as int)
