extends EnemyBase

func _ready() -> void:
	set_hp(30)
	strength = 10
	super._ready()

func _idle() -> void:
	if enter_state:
		enter_state = false
		_set_animation("idle")
		timer_state.wait_time = randf_range(1, 2)
		timer_state.start()
		
		await  timer_state.timeout
		_change_state(EnemyState.WALK)
		

func _walk(delta) -> void:
	if enter_state:
		enter_state = false
		timer_state.wait_time = randf_range(1, 3)
		timer_state.start()
		
		await  timer_state.timeout
		_change_state(EnemyState.IDLE)
		
	var target_distance = player.transform.origin - transform.origin
	velocity.x = target_distance.x / (abs(target_distance.x) * 2)
	
	walk_timer += delta
	if walk_timer >= randf_range(1,2):
		walk_timer = 0
		velocity.z = randi_range(0,1) if transform.origin.z < player.transform.origin.z else randi_range(-1,0)
		
	if abs(target_distance.x) < distance_attack:
		velocity.x = 0
		if abs(player.transform.origin.x - transform.origin.x) < 0.2 and abs(player.transform.origin.z - transform.origin.z) < 0.1:
			_change_state(EnemyState.ATTACK)
	
	if not velocity:
		_set_animation("idle")
	else:
		_set_animation("walk")
		
	_flip()
	move_and_slide()

func _attack() -> void:
	if enter_state:
		enter_state = false
		_stop_movement()
		_set_animation("attack")
		
		timer_state.wait_time = 0.5
		timer_state.start()

	if animated_sprite.frame == 3:
		_enter_attack()
		_play_sound(SOUNDS_GOBLIN[1])
	elif animated_sprite.frame > 4:
		_exit_attack()  
		
	if animated_sprite.frame >= 5:
		_change_state(EnemyState.IDLE)


func _hurt() -> void:
	if enter_state:
		enter_state = false
		_set_animation("hurt")
		timer_state.stop
		timer_state.wait_time = 0.2
		timer_state.start()
		
		await timer_state.timeout
		_change_state(EnemyState.IDLE)
		
func _dead() -> void:
	if enter_state:
		enter_state = false
		_set_animation("dead")
		_play_sound(SOUNDS_GOBLIN[0])
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
