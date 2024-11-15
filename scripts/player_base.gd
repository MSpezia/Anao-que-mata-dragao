class_name PlayerBase extends CharacterBody3D

enum StateMachine { IDLE, WALK, JUMP, ATTACK, ATTACK2, ATTACK3, HURT, BLOCK, DEAD }

const SOUNDS = [
	preload("res://audio/player_hurt.ogg"),
	preload("res://audio/swing2.wav"),
	preload("res://audio/jump.ogg"),
	preload("res://audio/player_dying.wav"),
	preload("res://audio/swing3.ogg"),
]

@export var hp := 100
@export var speed := 0.65
@export var jump_force := 2.5
@export var strength := 10

var gravity : float = 9.8
var state : StateMachine = StateMachine.IDLE
var enter_state : bool = true
var in_attack : bool = false
var camera_adjusted: float = 0.815
var is_blocking: bool = false

@onready var animated_sprite = $AnimatedSprite3D
@onready var attackCollision: CollisionShape3D =  $Attack/AttackHitbox
@onready var ui_main: UIMain = GameController.ui_main
@onready var health_component: HealthComponent = $HealthComponent
@onready var camera: Camera3D = get_parent().get_node("Camera")
@onready var audio : AudioStreamPlayer = get_node("AudioStreamPlayer")
@onready var block_area: Area3D = $block_area

var input : Vector2:
	get: return Input.get_vector("ui_left","ui_right","ui_up", "ui_down") * speed

var jump : bool:
	get: return Input.is_action_just_pressed("ui_accept")

var attack : bool:
	get: return Input.is_action_just_pressed("ui_attack")
	
func _ready() -> void:
	health_component.hp = hp
	health_component.on_damage.connect(func(hp: float): _change_state(StateMachine.HURT))
	health_component.on_dead.connect(func(): _change_state(StateMachine.DEAD))
	
	$Attack.area_entered.connect(func(hitbox: HitboxComponent): hitbox._take_damage(strength))

func _physics_process(delta: float) -> void:
	
	if state == StateMachine.DEAD:
		_dead()
		return
		
	match state:
		StateMachine.IDLE: _idle()
		StateMachine.WALK: _walk()
		StateMachine.JUMP: _jump()
		StateMachine.ATTACK: _attack()
		StateMachine.ATTACK2: _attack2()
		StateMachine.ATTACK3: _attack3()
		StateMachine.HURT: _hurt()
		StateMachine.BLOCK: _block()
		# StateMachine.DEAD: _dead()


	position.x = clamp(position.x, camera.position.x - camera_adjusted, camera.clamped + camera_adjusted)
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
func _attack() -> void: pass
func _attack2() -> void: pass
func _attack3() -> void: pass
func _hurt() -> void:pass
func _dead() -> void: pass
func _block() -> void: pass


func _movement() -> void:
	velocity.x = input.x
	velocity.z = input.y
	
func _stop_movement() -> void:
	velocity.x = 0
	velocity.z = 0
	
func _flip() -> void:
	if input.x:
		animated_sprite.flip_h = true if input.x < 0 else false
		$Attack.scale.x = -1 if input.x < 0 else 1
		
func _set_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
func _enter_attack() -> void:
	if not in_attack:
		in_attack = true
		attackCollision.disabled = false
		
func _exit_attack() -> void:
	if in_attack:
		in_attack = false
		attackCollision.disabled = true
		
func heal(amount: int) -> void:
	health_component.hp += amount
	health_component.hp = min(health_component.hp, 100)
	ui_main.update_health(health_component.hp)
	
func _play_sound(sound) -> void:
	audio.stream = sound
	audio.play()
