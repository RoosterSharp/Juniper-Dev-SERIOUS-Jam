@tool
extends Node2D

signal button_pressed(idx : int)

const CHAMBER_BUTTON = preload("res://scenes/dynamic_cylinder/chamber_button.tscn")
const DIVIT_DIST = 65
const SLOT_DIST = -40
const SLOT_WIDTH = 70

@export var num_slots := 6:
	set(value):
		num_slots = max(value,6)
		if Engine.is_editor_hint():
			_update()
@export var cylinder_tex : GradientTexture2D
@export var divit_tex : Texture2D
@export var slot_tex : Texture2D
@export var back_tex : Texture2D


@onready var canvas_group: CanvasGroup = $CanvasGroup

func _ready() -> void:
	set_num_slots(num_slots)

func set_num_slots(num):
	num_slots = max(num,6)
	_update()

func _update():
	for child in canvas_group.get_children():
		child.queue_free()
	
	var radius = ((SLOT_WIDTH*num_slots/PI)+SLOT_WIDTH)/2
	print(radius)
	
	# cylinder background
	# needs to not be affected by divit normals somehow
	var back_circle = Sprite2D.new()
	back_tex.height = radius*2.5
	back_tex.width = radius*2.5
	back_circle.texture = back_tex
	canvas_group.add_child(back_circle)
	
	
	cylinder_tex.height = int(radius)*2
	cylinder_tex.width = int(radius)*2
	
	var cylinder_spr = Sprite2D.new()
	cylinder_spr.texture = cylinder_tex
	canvas_group.add_child(cylinder_spr)
	for slot_idx in num_slots:
		
		var new_slot : ChamberButton = CHAMBER_BUTTON.instantiate()
		canvas_group.add_child(new_slot)
		new_slot.position = Vector2.UP.rotated(2*PI/num_slots*slot_idx)*(radius+SLOT_DIST)
		
		if !Engine.is_editor_hint():
			new_slot.button_idx = slot_idx
			new_slot.button_pressed.connect(func(i): button_pressed.emit(i))
		
		var new_divit = Sprite2D.new()
		canvas_group.add_child(new_divit)
		new_divit.texture = divit_tex
		
		
		var slot_width = 2*PI/num_slots
		new_divit.position = Vector2.UP.rotated(2*PI/num_slots*slot_idx+slot_width/2)*(radius+DIVIT_DIST)
		
