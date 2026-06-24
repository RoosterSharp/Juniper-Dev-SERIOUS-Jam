extends Window

@onready var buttons : Array[Button] = [$HBoxContainer/Button1,$HBoxContainer/Button2,$HBoxContainer/Button3]
var unlocks = [null,null,null]

func _ready():
	Cylinder.get_instance().emptied.connect(prompt_for_upgrade)


func prompt_for_upgrade():
	get_tree().paused = true
	show()
	var deck = Cylinder.get_instance().deck
	var locked_bullets = Bullet.get_bullet_list().filter(func(b): return !deck.has(b))
	print(locked_bullets)
	for i in min(3,locked_bullets.size()):
		unlocks[i] = locked_bullets.pick_random()
		locked_bullets.erase(unlocks[i])
		buttons[i].icon = unlocks[i].texture
	


func select(idx):
	Cylinder.get_instance().deck.append(unlocks[idx])
	get_tree().paused = false
	Cylinder.get_instance().fill_cylinder()
	hide()


func _on_button_1_button_down():
	select(0)


func _on_button_2_button_down():
	select(1)


func _on_button_3_button_down():
	select(2)
