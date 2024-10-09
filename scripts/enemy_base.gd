class_name EnemyBase extends CharacterBody3D

enum EnemyState {IDLE, WALK}

@export var strenght = 5
@export var hp = 30
@export var speed = 0.5
var gravity : float = 9.8
var death : bool
var walk_timer : float
var face_right : bool
var animation : String
@onready var animated_sprite : AnimatedSprite3D = $AnimatedSprite3D
@onready var timer_state : Timer = $Timer
@onready var player : CharacterBody3D = %Player
var state : EnemyState = EnemyState.IDLE	
var enter_state : bool = true

func _physics_process(delta: float) -> void:
	match state:
		EnemyState.IDLE: _idle()
		EnemyState.WALK: _walk(delta)
		
		
func _enter_state() -> void:
	if enter_state:
		enter_state = false
		animated_sprite.play(animation)


func _change_state(new_state: EnemyState) -> void:
	if state != new_state:
		state = new_state
		enter_state = true

func _idle() -> void: pass
func _walk(delta: float) -> void: pass

func _stop_movement() -> void:
	velocity.x = 0
	velocity.z = 0
	
	
func _set_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
		

func _flip() -> void:
	face_right = true if player.transform.origin.x > transform.origin.x else false
	if face_right:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _set_animation(anim: String) -> void:
	if animation != anim:
		animation = anim
		animated_sprite.play(animation)
