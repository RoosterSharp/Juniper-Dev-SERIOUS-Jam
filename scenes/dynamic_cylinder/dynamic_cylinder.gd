@tool
class_name DynamicCylinder
extends Node2D

signal button_pressed(idx : int)

const BARREL_SIZE = 1000
const CHAMBER_BUTTON = preload("res://scenes/dynamic_cylinder/chamber_button.tscn")
const DIVIT_DIST = 32
const SLOT_DIST = -20
const SLOT_WIDTH = 35

static var _node : DynamicCylinder
var selected_chamber = 0

@export var num_slots := 6:
	set(value):
		num_slots = max(value,6)
		if Engine.is_editor_hint():
			_update()
@export var cylinder_tex : GradientTexture2D
@export var divit_tex : Texture2D


@onready var canvas_group: CanvasGroup = $CanvasGroup
@onready var barrel_button: Node2D = $BarrelButton

var grabbed = false
var grab_dist
var grab_angle
var mouse_warped = false

func _ready() -> void:
	set_num_slots(num_slots)

func _init():
	_node = self

func _input(event: InputEvent) -> void:
	if !grabbed:
		return
		
	if event is InputEventMouseMotion: 
		if !mouse_warped:
			var screen_pos = get_global_transform_with_canvas().origin
			var warp_to = (event.position-screen_pos).normalized()*grab_dist+screen_pos
			get_viewport().warp_mouse(warp_to)
			mouse_warped = true
			
			var diff = get_viewport().get_mouse_position() - screen_pos
			var curr_angle = atan2(diff.y,diff.x)
			rotation = curr_angle - grab_angle
		else:
			mouse_warped = false

static func get_instance() -> DynamicCylinder:
	return _node

func set_num_slots(num):
	num_slots = max(num,6)
	_update()

func _update():
	for child in canvas_group.get_children():
		child.queue_free()
	
	var radius = get_radius()
	
	var cylinder_spr = Sprite2D.new()
	cylinder_spr.texture = cylinder_tex
	canvas_group.add_child(cylinder_spr)
	cylinder_spr.scale = Vector2.ONE*radius*2/BARREL_SIZE
	barrel_button.scale = cylinder_spr.scale*1.1
	
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

func get_radius():
	return ((SLOT_WIDTH*num_slots/PI)+SLOT_WIDTH)/2

func _grab():
	grabbed = true
	var screen_pos = get_global_transform_with_canvas().origin
	grab_dist = get_viewport().get_mouse_position().distance_to(screen_pos)
	var diff = get_viewport().get_mouse_position() - screen_pos
	grab_angle = atan2(diff.y,diff.x) - rotation

func _release():
	grabbed = false
	selected_chamber = wrap(roundf(-rotation/(2.0*PI)*num_slots),0,num_slots)
	print(selected_chamber)
	snap()

func snap():
	var snapped_rotation = roundf(rotation/(2.0*PI)*num_slots)/num_slots*2.0*PI
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self,"rotation",snapped_rotation,0.2)
