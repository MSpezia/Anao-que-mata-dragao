extends CanvasLayer
class_name UIMain

@onready var health: ProgressBar = $Player/Health

func update_health(value : int) -> void:
	health.value = value
