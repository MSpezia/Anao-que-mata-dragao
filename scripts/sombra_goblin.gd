extends Sprite3D

@export var goblin : Node3D
var y_position = 0

func _ready():
	y_position = global_transform.origin.y -0.1

func _process(delta):
	global_transform.origin.x = goblin.global_transform.origin.x
	global_transform.origin.z = goblin.global_transform.origin.z
	global_transform.origin.y = y_position
