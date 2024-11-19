extends Control

func _ready() -> void:
	$Button.connect("pressed", self.menu)
	$Button2.connect("pressed", self.sair)

func menu() -> void:
	get_tree().change_scene_to_file("res://Cenas/MenuPrincipal.tscn")

func sair() -> void:
	get_tree().quit()
