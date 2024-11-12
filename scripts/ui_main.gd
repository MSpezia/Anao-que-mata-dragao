extends CanvasLayer
class_name UIMain

@onready var health: TextureProgressBar = $Player/Health

func update_health(value : int) -> void:
	health.value = value
