class_name EnemyBase extends CharacterBody3D

enum EnemyState {IDLE}

@export var strenght = 5
@export var hp = 30
@export var speed = 0.65
@onready var animated_sprite : AnimatedSprite3D = $AnimatedSprite3D
var state : EnemyState = EnemyState.IDLE	
var enter_state : bool = true

func _physics_process(delta: float) -> void:
	match state:
		EnemyState.IDLE: _idle()
		
		
func _enter_state(animation: String) -> void:
	if enter_state:
		enter_state = false
		animated_sprite.play(animation)


func _change_state(new_state: EnemyState) -> void:
	if state != new_state:
		state = new_state
		enter_state = true

func _idle() -> void: pass
