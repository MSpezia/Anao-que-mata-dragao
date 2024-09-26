class_name Character extends CharacterBody3D

enum StateMachine { IDLE , WALK, JUMP}


@export var speed := 0.65
@export var jump_force := 2.5
var gravity : float = 9.8

var state : StateMachine = StateMachine.IDLE
var enter_state : bool = true

@onready var animated_sprite = $AnimatedSprite3D

var input : Vector2:
	get: return Input.get_vector("ui_left","ui_right","ui_up", "ui_down") * speed
	
var jump : bool:
	get: return Input.is_action_just_pressed("ui_accept")

func _physics_process(delta: float) -> void:
	match state:
		StateMachine.IDLE: _idle()
		StateMachine.WALK: _walk()
		StateMachine.JUMP: _jump()
		
	_set_gravity(delta)
	move_and_slide()

func _enter_state(animation: String) -> void:
	if enter_state:
		enter_state = false
		animated_sprite.play(animation)


func _change_state(new_state: StateMachine) -> void:
	if state != new_state:
		state = new_state
		enter_state = true
		
		
func _idle() -> void: pass
func _walk() -> void: pass
func _jump() -> void: pass

func _movement() -> void:
	velocity.x = input.x
	velocity.z = input.y
	
func _stop_movement() -> void:
	velocity.x = 0
	velocity.z = 0
	
func _flip() -> void:
	if input.x:
		animated_sprite.flip_h = true if input.x < 0 else false
		
func _set_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
