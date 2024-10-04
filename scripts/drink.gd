extends Area3D

@export var heal_amount : int = 25


func _on_body_entered(body: Node) -> void:
	if body is Player:
		print("Colisão detectada com: ", body)
		body.heal(heal_amount)
		queue_free()
		
