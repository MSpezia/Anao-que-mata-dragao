extends Node3D

@onready var fundo_1 : Sprite3D = $fundo_1
@onready var fundo_2 : Sprite3D = $fundo_2
@onready var fundo_3 : Sprite3D = $fundo_3

var parallax_intensity_1 = 0
var parallax_intensity_2 = 0.2
var parallax_intensity_3 = 0.1

func _process(delta):
	var camera_position_x = GameController.camera.global_transform.origin.x
	
	fundo_1.position.x = camera_position_x * parallax_intensity_1
	fundo_2.position.x = camera_position_x * parallax_intensity_2
	fundo_3.position.x = camera_position_x * parallax_intensity_3
