extends Character

func _idle() -> void:
	_enter_state("idle")
	_stop_movement()
	
	if input:
		_change_state(StateMachine.WALK)
		
	if jump:
		_change_state(StateMachine.JUMP)

func _walk() -> void:
	_enter_state("walk")
	_movement()
	_flip()
	
	if not input:
		_change_state(StateMachine.IDLE)
		
	if jump:
		_change_state(StateMachine.JUMP)

func _jump() -> void:
	_movement()
	_flip()
	
	if enter_state:
		enter_state = false
		velocity.y = jump_force
		animated_sprite.play("jump")
		await get_tree().create_timer(0.2).timeout

	if not is_on_floor():
		if velocity.y <= 0:
			animated_sprite.play("falling")
	if is_on_floor():
		animated_sprite.play("landing")
		if input:
			_change_state(StateMachine.IDLE)
		else:
			await get_tree().create_timer(0.05).timeout
			_change_state(StateMachine.IDLE)
