class_name GameController extends Node

@export var _player: Player
@export var _camera: Camera3D
@export var _ui_main: UIMain

static var player: Player
static var camera: Camera3D
static var ui_main: UIMain

func _enter_tree() -> void:
	player = _player
	camera = _camera
	ui_main = _ui_main
