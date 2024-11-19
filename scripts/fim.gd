extends Control

func _ready() -> void:
	$Button.connect("pressed", self._ir_para_creditos)

func _ir_para_creditos() -> void:
	get_tree().change_scene_to_file("res://cenas/TelaCreditos.tscn")
