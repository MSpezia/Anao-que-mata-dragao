extends Control

func _ready():
	$JogarButton.pressed.connect(_on_JogarButton_pressed)
	$SairButton.pressed.connect(_on_SairButton_pressed)
	$ContinuarButton.pressed.connect(_on_continuar_pressed)
	$creditos.pressed.connect(_on_creditos_pressed)

func _on_JogarButton_pressed():
	game_controller.save_progress(1)
	get_tree().change_scene_to_file("res://cenas/Fase_1.tscn")

func _on_SairButton_pressed():
	get_tree().quit()
	
func _on_continuar_pressed():
	var fase = game_controller.load_progress()
	if fase == 1:
		get_tree().change_scene_to_file("res://cenas/Fase_1.tscn")
	elif fase == 2:
		get_tree().change_scene_to_file("res://cenas/Fase_2.tscn")

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://cenas/TelaCreditos.tscn")
