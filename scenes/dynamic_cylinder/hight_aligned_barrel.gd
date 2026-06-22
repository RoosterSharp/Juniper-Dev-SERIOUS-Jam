extends Node2D


@onready var pivot: Node2D = $"."
@onready var dynamic_cylinder: Node2D = $DynamicCylinder

func _process(_delta: float) -> void:
	pivot.position.y = dynamic_cylinder.get_radius()+DynamicCylinder.SLOT_DIST
