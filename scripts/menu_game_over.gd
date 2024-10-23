extends Control

func _ready():
	hide()
	$reiniciar.pressed.connect(_on_reiniciar_pressed)
	$sair.pressed.connect(_on_sair_pressed)

func _on_reiniciar_pressed():
	get_tree().reload_current_scene()

func _on_sair_pressed():
	get_tree().quit()

func mostrar_menu():
	show()
