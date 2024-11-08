extends Control

func _ready():
	hide()
	$menu.pressed.connect(_on_menu_pressed)

func continuar():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func Esc():
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		continuar()

func _on_continuar_pressed():
	continuar()

func _on_sair_pressed():
	get_tree().quit()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/MenuPrincipal.tscn")

func _process(delta):
	Esc()
