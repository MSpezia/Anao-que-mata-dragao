extends BossBase

var pedra = preload("res://item/fireball.tscn")
var has_fired = false

func _ready() -> void:
	set_hp(1)
	strength = 25
	distance_attack = 0.4
	gravity = 0
	super._ready()

func _idle() -> void:
	if enter_state:
		enter_state = false
		_set_animation("idle")
		timer_state.wait_time = randf_range(0.5, 1)
		timer_state.start()

		await timer_state.timeout

		var target_distance = player.transform.origin - transform.origin
		var distancia_x = abs(target_distance.x)

		if distancia_x > distance_attack and distancia_x < 1.3:
			_change_state(EnemyState.FIRE)
		else:
			_change_state(EnemyState.ATTACK)

func _attack() -> void:
	if enter_state:
		enter_state = false
		_stop_movement()
		_set_animation("attack")
		timer_state.wait_time = 1.4
		timer_state.start()

	if animated_sprite.frame == 4:
		_enter_attack()
	if animated_sprite.frame == 6:
		_exit_attack()
	elif animated_sprite.frame >= 11:
		_change_state(EnemyState.IDLE)

func _fire() -> void:
	if enter_state:
		enter_state = false
		_stop_movement()
		_set_animation("fire")
		timer_state.wait_time = 2
		timer_state.start()

	if animated_sprite.frame == 15 and not has_fired:
		has_fired = true
		fire()
	elif animated_sprite.frame > 15:
		has_fired = false

	if animated_sprite.frame >= 17:
		_change_state(EnemyState.IDLE)

func _dead() -> void:
	if enter_state:
		enter_state = false
		_set_animation("dead")
		_play_sound(SOUNDS_GOBLIN[0])
		collision.disabled = true
		velocity.x = 1 if player.global_position.x < global_position.x else -1
		velocity.y = 3
		velocity.z = 0
		timer_state.stop()
		GameController.level_controller.enemy_death()
		await get_tree().create_timer(1).timeout
		queue_free()
	move_and_slide()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Cenas/Fim.tscn")
