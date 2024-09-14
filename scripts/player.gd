extends CharacterBody3D


const SPEED = 2
const JUMP_VELOCITY = 2.5


@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if velocity.x > 0:
		animated_sprite_3d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_3d.flip_h = true
		
	if velocity.x == 0:
		animated_sprite_3d.play("idle")
	else:
		animated_sprite_3d.play("walk")
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED * 2 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
