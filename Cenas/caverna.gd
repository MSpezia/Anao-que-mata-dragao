extends Area3D

@export var unclocked_at_area: float
@export var amount: int = 0
@export var enemies: Array[PackedScene]

@onready var camera: Camera3D = GameController.camera

func _ready() -> void:
	body_entered.connect(func(player: Player): fase_2())
	
func fase_2() ->void:
	GameController.level_controller.boss1_defeated()
