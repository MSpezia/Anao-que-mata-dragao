extends Area3D


func _on_body_entered(player: Node3D) -> void:
	if player is Player:
		player._take_damage(50)
