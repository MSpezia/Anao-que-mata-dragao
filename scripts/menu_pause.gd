extends Control

func _ready():
	hide()
	$menu.pressed.connect(_on_menu_pressed)
	var initial_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))) * 100
	$HSlider.value = initial_volume

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

func _on_h_slider_value_changed(value: float) -> void:
	var normalized_volume = value / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(normalized_volume))

func linear_to_db(value: float) -> float:
	return 20 * (log(value) / log(10)) if value > 0 else -80
