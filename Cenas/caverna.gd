extends Area3D

func _ready() -> void:
	body_entered.connect(func(player: Player): fase_2())
	
func fase_2() ->void:
	GameController.level_controller.boss1_defeated()
