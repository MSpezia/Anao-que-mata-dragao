extends Area3D

@export var unclocked_at_area: float
@export var amount: int = 0
@export var enemies: Array[PackedScene]

@onready var camera: Camera3D = GameController.camera

func _ready() -> void:
	body_entered.connect(func(player: Player): _spawn_enemies())
	
func _spawn_enemies() ->void:
	for i in amount:
		var enemy = enemies[randi() % enemies.size()].instantiate()
		enemy.position = _set_enemy_random_position()
		enemy.rotation.x = deg_to_rad(-26)
		get_parent().add_child(enemy)
	
	GameController.level_controller.config_next_area(amount, unclocked_at_area)
	queue_free()
		
		
func _set_enemy_random_position() -> Vector3:
	var side := randi_range(0,1)
	var new_posisiton: Vector3
	
	match side:
		0: new_posisiton = _get_camera_position(-1.2)
		1: new_posisiton = _get_camera_position(1.2)
		
	return new_posisiton
	
func _get_camera_position(value: float) -> Vector3:
	return Vector3(camera.position.x + value, 0.532, randf_range(-0.75,0.26))
