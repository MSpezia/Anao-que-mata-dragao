extends Area3D

var velocity = Vector3.ZERO
var range = 1.4
var speed = 1
var start_position = Vector3.ZERO

@onready var player : CharacterBody3D = GameController.player

func _ready() -> void:
	start_position = global_position

func _set_direction(direction: Vector3) -> void:
	velocity = direction.normalized() * speed
	
func _process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range:
		queue_free()

func _on_body_entered(body) -> void:
		if body is Player:
			body.get_node("HealthComponent").take_damage(20)
			queue_free()
