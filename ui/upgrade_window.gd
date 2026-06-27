extends Control

@onready var buttons : Array[Button] = [$Panel/HBoxContainer/Button1, $Panel/HBoxContainer/Button2]
var curr_benifits = [null,null]
var curr_drawbacks = [null,null]

var benifits = [
	preload("res://upgrades/benifits/guard.tres"), 
	preload("res://upgrades/benifits/heal.tres"), 
	preload("res://upgrades/benifits/hot_heal.tres"), 
	preload("res://upgrades/benifits/hot_shot.tres"), 
	preload("res://upgrades/benifits/toy_dart.tres"),
]

var drawbacks = [
	preload("res://upgrades/drawbacks/cold.tres"),
	preload("res://upgrades/drawbacks/cold.tres"),
]

func _ready():
	Cylinder.get_instance().emptied.connect(prompt_for_upgrade)


func prompt_for_upgrade():
	get_tree().paused = true
	DynamicCylinder.get_instance().process_mode = Node.PROCESS_MODE_ALWAYS
	DynamicCylinder.get_instance().rotation = 0
	var cylinder = Cylinder.get_instance()
	ChamberButton.show_tooltip = true
	cylinder.heat = 0
	cylinder.disp_heat()
	cylinder.clear()
	
	var bullet_list = Cylinder.get_instance().obtained_bullet_list
	
	for i in bullet_list.size():
		cylinder.set_chamber(i,bullet_list[i])
	
	show()
	
	#var locked_bullets = Bullet.get_bullet_list().filter(func(b): return !bullet_list.has(b))
	var temp_benifits = benifits.duplicate()
	var temp_drawbacks = drawbacks.duplicate()
	for i in 2:
		var b = temp_benifits.pick_random()
		temp_benifits.erase(b)
		curr_benifits[i] = b
		
		var d = temp_drawbacks.pick_random()
		temp_drawbacks.erase(d)
		curr_drawbacks[i] = d
		
		buttons[i].set_benifit(b.get_title(), b.get_description(),b.get_texture())
		buttons[i].set_drawback(d.get_title(), d.get_description(),d.get_texture())


func select(idx):
	var cylinder = Cylinder.get_instance()
	curr_benifits[idx].apply()
	curr_drawbacks[idx].apply()
	
	get_tree().paused = false
	var dc = DynamicCylinder.get_instance()
	dc.process_mode = Node.PROCESS_MODE_INHERIT
	dc.rotation = 0
	dc.selected_chamber = 0
	ChamberButton.show_tooltip = false
	cylinder.clear()
	cylinder.fill_cylinder()
	hide()
