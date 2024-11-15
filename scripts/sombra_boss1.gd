extends Sprite3D

@export var boss1 : Node3D
var y_position = 0

func _ready():
	y_position = global_transform.origin.y

func _process(delta):
	global_transform.origin.x = boss1.global_transform.origin.x
	global_transform.origin.z = boss1.global_transform.origin.z
	global_transform.origin.y = y_position
