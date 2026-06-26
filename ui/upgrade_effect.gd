extends VBoxContainer

@onready var container: VBoxContainer = $"."
@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label

func set_info(title : String, description : String, icon_tex : Texture2D):
	container.tooltip_text = description
	icon.texture = icon_tex
	label.text = title
