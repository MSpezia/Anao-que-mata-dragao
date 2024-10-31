extends EnemyBase

@export var flee_distance = 0.5
@export var approach_distance = 0.6
@export var attack_cooldown = 2.0
@export var speed = 0.5
var can_attack = true

var pedra = preload("res://item/pedra.tscn")

func _ready() -> void:
	set_hp(20)
	super._ready()
	_change_state(EnemyState.WALK)

func _walk(delta: float) -> void:
	if enter_state:
		enter_state = false
		_set_animation("walk")

	var target_distance = player.global_transform.origin - global_transform.origin
	var distance_to_player = target_distance.length()

	if distance_to_player < flee_distance:
		var flee_direction = -target_distance.normalized()
		velocity = flee_direction * speed
	elif distance_to_player > approach_distance:
		var approach_direction = target_distance.normalized()
		velocity = approach_direction * speed
	elif can_attack:
		_change_state(EnemyState.ATTACK)
	
	move_and_slide()

func _attack() -> void:
	if enter_state:
		enter_state = false
		_stop_movement()
		_set_animation("attack")
		
		fire_projectile()
		can_attack = false
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
		
		_change_state(EnemyState.WALK)


func _hurt() -> void:
	if enter_state:
		enter_state = false
		_set_animation("hurt")
		timer_state.stop()
		timer_state.wait_time = randf_range(0.4, 0.7)
		timer_state.start()
		
		await timer_state.timeout
		_change_state(EnemyState.WALK)

func _dead() -> void:
	if enter_state:
		enter_state = false
		_set_animation("dead")
		collision.disabled = true
		drop_item()
		velocity.x = 1 if player.global_position.x < global_position.x else -1
		velocity.y = 3
		velocity.z = 0
		timer_state.stop()
		GameController.level_controller.enemy_death()
		await get_tree().create_timer(1).timeout

		queue_free()
	move_and_slide()
