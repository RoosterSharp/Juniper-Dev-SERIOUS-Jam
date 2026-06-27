extends Control

@onready var buttons : Array[Button] = [$Panel/HBoxContainer/Button1, $Panel/HBoxContainer/Button2]
var unlocks = [null,null]

func _ready():
	Cylinder.get_instance().emptied.connect(prompt_for_upgrade)


func prompt_for_upgrade():
	get_tree().paused = true
	DynamicCylinder.get_instance().process_mode = Node.PROCESS_MODE_ALWAYS
	DynamicCylinder.get_instance().rotation = 0
	var deck = Cylinder.get_instance().deck
	var cylinder = Cylinder.get_instance()
	ChamberButton.show_tooltip = true
	cylinder.heat = 0
	cylinder.disp_heat()
	cylinder.clear()
	for i in deck.size():
		cylinder.set_chamber(i,deck[i])
	
	show()
	
	var locked_bullets = Bullet.get_bullet_list().filter(func(b): return !deck.has(b))
	for i in min(2,locked_bullets.size()):
		unlocks[i] = locked_bullets.pick_random()
		locked_bullets.erase(unlocks[i])
		buttons[i].set_benifit(unlocks[i].display_name, unlocks[i].get_description(),unlocks[i].texture)
	


func select(idx):
	var cylinder = Cylinder.get_instance()
	cylinder.deck.append(unlocks[idx])
	get_tree().paused = false
	DynamicCylinder.get_instance().process_mode = Node.PROCESS_MODE_INHERIT
	ChamberButton.show_tooltip = false
	cylinder.clear()
	cylinder.fill_cylinder()
	hide()
	
