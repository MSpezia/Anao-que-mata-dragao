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
	
func save_progress(fase_atual: int) -> void:
	var save_data = {"fase": fase_atual}
	var file = FileAccess.open("user://save_game.save", FileAccess.ModeFlags.WRITE)
	file.store_var(save_data)
	file.close()

func load_progress() -> int:
	if FileAccess.file_exists("user://save_game.save"):
		var file = FileAccess.open("user://save_game.save", FileAccess.ModeFlags.READ)
		var save_data = file.get_var()
		file.close()
		return save_data.get("fase", 1)
	return 1
