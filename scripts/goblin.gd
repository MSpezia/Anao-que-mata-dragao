extends EnemyBase

func _ready() -> void:
	state = EnemyState.IDLE
	
	
func _idle() -> void:
	_enter_state("idle")
	
func _walk() -> void:
	_enter_state("walk")
