extends Camera3D

var smooth := 4
var clamped := 0

@onready var player: Player = GameController.player

func _process(delta: float) -> void:
	if position.x < player.position.x:
		position.x = lerp(position.x, player.position.x, smooth * delta)
		position.x = clamp(position.x, -0.6, clamped)

func set_camera_limit(limit: float) -> void:
	clamped = limit
