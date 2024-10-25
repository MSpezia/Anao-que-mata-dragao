class_name EnemyBase extends CharacterBody3D

enum EnemyState {IDLE, WALK, ATTACK, HURT, DEAD}

@export var strength = 10
@export var hp = 30
@export var distance_attack = 0.1
var gravity : float = 9.8
var death : bool
var walk_timer : float
var face_right : bool
var animation : String
var in_attack: bool
@onready var animated_sprite : AnimatedSprite3D = $AnimatedSprite3D
@onready var timer_state : Timer = $Timer
@onready var player : CharacterBody3D = GameController.player
@onready var attack : Area3D = $Attack
@onready var attack_collision: CollisionShape3D = $Attack/Collision
var state : EnemyState = EnemyState.IDLE	
var enter_state : bool = true
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision : CollisionShape3D = $HitboxComponent/HitboxCollision

func _ready() -> void:
	health_component.hp = hp
	health_component.on_damage.connect(func(hp: float): _change_state(EnemyState.HURT))
	health_component.on_dead.connect(func(): _change_state(EnemyState.DEAD))
	
	attack.area_entered.connect(func(hitbox: HitboxComponent): hitbox._take_damage(strength))

func _physics_process(delta: float) -> void:
	match state:
		EnemyState.IDLE: _idle()
		EnemyState.WALK: _walk(delta)
		EnemyState.ATTACK: _attack()
		EnemyState.HURT: _hurt()
		EnemyState.DEAD: _dead()
		
		
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
func _attack() -> void: pass
func _hurt() -> void: pass
func _dead() -> void: pass

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
		attack.scale.x = -1
	else:
		animated_sprite.flip_h = false
		attack.scale.x = 1

func _set_animation(anim: String) -> void:
	if animation != anim:
		animation = anim
		animated_sprite.play(animation)
		
func _enter_attack() -> void:
	if not in_attack:
		in_attack = true
		attack_collision.disabled = false
		
func _exit_attack() -> void:
	if in_attack:
		in_attack = false
		attack_collision.disabled = true
		
func drop_item() -> void:
	var drop = randi_range(0, 100)
	if drop <= 15:
		var drink = preload("res://item/Drink.tscn").instantiate()
		drink.position = position
		get_parent().add_child(drink)
