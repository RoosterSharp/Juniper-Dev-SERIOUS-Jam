extends Control

@onready var buttons : Array[Button] = [$Panel/HBoxContainer/Button1, $Panel/HBoxContainer/Button2]
var unlocks = [null,null]

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
	
	var locked_bullets = Bullet.get_bullet_list().filter(func(b): return !bullet_list.has(b))
	for i in min(2,locked_bullets.size()):
		unlocks[i] = locked_bullets.pick_random()
		locked_bullets.erase(unlocks[i])
		buttons[i].set_benifit(unlocks[i].display_name, unlocks[i].get_description(),unlocks[i].texture)


func select(idx):
	var cylinder = Cylinder.get_instance()
	cylinder.add_bullet(unlocks[idx])
	
	get_tree().paused = false
	var dc = DynamicCylinder.get_instance()
	dc.process_mode = Node.PROCESS_MODE_INHERIT
	dc.rotation = 0
	dc.selected_chamber = 0
	ChamberButton.show_tooltip = false
	cylinder.clear()
	cylinder.fill_cylinder()
	hide()
	
