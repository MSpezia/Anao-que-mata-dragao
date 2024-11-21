extends Area3D

@export var heal_amount: int = 25
@export var audios: Array = ["res://audio/burp.ogg", "res://audio/gulp1.ogg", "res://audio/gulp2.ogg"]

var initial_position: Vector3

func _ready() -> void:
	initial_position = global_transform.origin

func _process(delta: float) -> void:
	var offset_y = abs(sin(Time.get_ticks_msec() / 1000.0 * 1.5)) * 0.02
	var new_position = initial_position
	new_position.y += offset_y
	global_transform.origin = new_position

func _on_body_entered(body: Node) -> void:
	if body is Player:
		var random_audio = audios[randi() % audios.size()]
		var audio_player = get_node("../AudioStreamPlayer")
		audio_player.stream = load(random_audio)
		audio_player.play()
		
		body.heal(heal_amount)
		queue_free()
