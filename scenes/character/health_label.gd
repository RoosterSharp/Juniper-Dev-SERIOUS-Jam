extends Label

func _process(delta: float) -> void:
	var health = Character.get_instance().health
	var max_health = Character.get_instance().max_health
	
	text = "Health: %d/%d" % [health, max_health]
