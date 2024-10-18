class_name GameController extends Node

@export var _player: Player
@export var _camera: Camera3D
@export var _ui_main: UIMain
@export var _level_controller: LevelController

static var player: Player
static var camera: Camera3D
static var ui_main: UIMain
static var level_controller: LevelController

func _enter_tree() -> void:
	player = _player
	camera = _camera
	ui_main = _ui_main
	level_controller = _level_controller
