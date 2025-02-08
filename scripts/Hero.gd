extends CharacterBody2D

@export var speed: float = 100.0  # Movement speed
@export var jump_force: float = -200.0  # Jump strength (negative = up)
@export var gravity: float = 800.0  # Gravity force

func _process(delta):
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.play("run_right")
	else:
		$AnimatedSprite2D.play("idle")

	$AnimatedSprite2D.flip_h = Input.is_action_pressed("move_left")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle movement input
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)  # Smooth stopping

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Apply movement
	move_and_slide()

func super_jump():
	velocity.y = jump_force * 2
