extends CharacterBody2D

@export var speed: float = 100.0  # Movement speed
@export var jump_force: float = -200.0  # Jump strength (negative = up)
@export var gravity: float = 800.0  # Gravity force

var is_facing_right: bool = true
var spend_fuel_duration: float = 0
var fuel_to_burn: float = 0

func _ready():
	GlobalSignals.update_fuel_remaining.connect(_update_fuel_remaining)

func _update_fuel_remaining(fuel_left):
	fuel_to_burn = fuel_left
	
func _process(delta):
	var tween: Tween = create_tween()
	if Input.is_action_pressed("fart"):
		spend_fuel_duration += delta
		
		if fuel_to_burn:
			_fart()
			
		GlobalSignals.spend_fuel.emit(spend_fuel_duration)
		tween.tween_property($SoundFart, "volume_db", 0, 0)
	else:
		spend_fuel_duration = 0
		tween.tween_property($SoundFart, "volume_db", -50, 1)

	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.play("run_right")
	else:
		$AnimatedSprite2D.play("idle")
		$SoundFootsteps.stop()
		
	if Input.is_action_just_pressed("move_left"):
		$SoundFootsteps.play()
		is_facing_right = false
	elif Input.is_action_just_pressed("move_right"):
		$SoundFootsteps.play()
		is_facing_right = true

	$AnimatedSprite2D.flip_h = !is_facing_right

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle movement input
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta * 2)  # Smooth stopping

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$SoundJump.play()
		velocity.y = jump_force

	# Apply movement
	move_and_slide()
	
func _fart():
	if not $SoundFart.is_playing():
		$SoundFart.play()
		
	# velocity.y = jump_force * 1.25
	velocity.y = jump_force * 1.05

func super_jump():
	$SoundSuperJump.play()
	velocity.y = jump_force * 3


