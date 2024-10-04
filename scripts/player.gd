class_name Player extends PlayerBase

func _idle() -> void:
	_enter_state("idle")
	_stop_movement()
	
	if input:
		_change_state(StateMachine.WALK)
		
	if jump:
		_change_state(StateMachine.JUMP)
		
	if attack:
		_change_state(StateMachine.ATTACK)

func _walk() -> void:
	_enter_state("walk")
	_movement()
	_flip()
	
	if not input:
		_change_state(StateMachine.IDLE)
		
	if jump:
		_change_state(StateMachine.JUMP)
	
	if attack:
		_change_state(StateMachine.ATTACK)

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
			
func _attack() -> void:
	_enter_state("attack")
	_stop_movement()
	if animated_sprite.frame == 1:
		_enter_attack()
	if animated_sprite.frame >= 3:
		_exit_attack()
	if animated_sprite.frame >= 4:
		_change_state(StateMachine.IDLE)

	if animated_sprite.frame >= 1 and attack:
		_change_state(StateMachine.ATTACK2)
		
func _attack2() -> void:
	_enter_state("attack2")
	if animated_sprite.frame == 1:
		_enter_attack()
	if animated_sprite.frame >= 3:
		_exit_attack()
	_stop_movement()
	
	if animated_sprite.frame >= 3:
		_change_state(StateMachine.IDLE)

	if animated_sprite.frame >= 0 and attack:
		_change_state(StateMachine.ATTACK3)
		
func _attack3() -> void:
	_enter_state("attack3")
	if animated_sprite.frame == 1:
		_enter_attack()
	_stop_movement()
	
	if animated_sprite.frame >= 5:
		_exit_attack()
		_change_state(StateMachine.IDLE)
		
func _hurt() -> void:
	if enter_state:
		enter_state = false
		animated_sprite.play("hurt")
		_stop_movement()
		
		await get_tree().create_timer(0.5).timeout
		_change_state(StateMachine.IDLE)
		
func _dead() -> void:
	if enter_state:
		enter_state = false
		animated_sprite.play("dead")
		_stop_movement()
		print("morreu")
		
