extends Control

func _ready():
	$VBoxContainer/JogarButton.pressed.connect(_on_JogarButton_pressed)
	$VBoxContainer/SairButton.pressed.connect(_on_SairButton_pressed)

func _on_JogarButton_pressed():
	get_tree().change_scene_to_file("res://Cenas/Fase_1.tscn")

func _on_SairButton_pressed():
	get_tree().quit()
