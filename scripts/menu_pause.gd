extends Control

func _ready():
	hide()

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

func _process(delta):
	Esc()
