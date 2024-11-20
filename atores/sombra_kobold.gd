extends Sprite3D

@export var kobold : Node3D
var y_position = 0

func _ready():
	y_position = global_transform.origin.y

func _process(delta):
	global_transform.origin.x = kobold.global_transform.origin.x
	global_transform.origin.z = kobold.global_transform.origin.z
	global_transform.origin.y = y_position
