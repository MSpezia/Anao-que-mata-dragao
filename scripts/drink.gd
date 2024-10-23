extends Area3D

@export var heal_amount : int = 25
@export var audios: Array = ["res://audio/burp.ogg" ,"res://audio/gulp1.ogg", "res://audio/gulp2.ogg" ]

func _on_body_entered(body: Node) -> void:
	if body is Player:
		
		var random_audio = audios[randi() % audios.size()]
		var audio_player = get_node("../AudioStreamPlayer")
		audio_player.stream = load(random_audio)
		audio_player.play()
		
		print("Colisão detectada com: ", body)
		body.heal(heal_amount)
		queue_free()
		
