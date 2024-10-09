extends EnemyBase

	
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
		timer_state.wait_time = randf_range(2, 4)
		timer_state.start()
		
		await  timer_state.timeout
		_change_state(EnemyState.IDLE)
		
	var target_distance = player.transform.origin - transform.origin
	velocity.x = target_distance.x / abs(target_distance.x)
	
	walk_timer += delta
	if walk_timer >= randf_range(1,2):
		walk_timer = 0
		velocity.z = randi_range(0,1) if transform.origin.z < player.transform.origin.z else randi_range(-1,0)
		
	if abs(target_distance.x) < distance_attack:
		velocity.x = 0
		if abs(player.transform.origin.x - transform.origin.x) < 0.2:
			_change_state(EnemyState.ATTACK)
	
	if not velocity:
		_set_animation("idle")
	else:
		_set_animation("walk")
		
	_flip()
	move_and_slide()
	
func _attack() ->void:
	if enter_state:
		enter_state = false
		_stop_movement()
		_enter_attack()
		_set_animation("attack")
		
		timer_state.wait_time = 0.5
		timer_state.start()
		
		await timer_state.timeout
		_exit_attack()
		_change_state(EnemyState.IDLE)
		
		
