extends Area3D

func _ready() -> void:
	body_entered.connect(func(player: Player): fim())
	
func fim() ->void:
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://Cenas/Fim.tscn")
