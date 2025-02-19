extends CharacterBody2D

@export var speed: float = 100.0  # Movement speed
@export var jump_force: float = -200.0  # Jump strength (negative = up)
@export var gravity: float = 800.0  # Gravity force

var is_facing_right: bool = true
var spend_fuel_duration: float = 0
var fuel_to_burn: float = 0
var tile_map: TileMap

func _ready():
	tile_map = get_node('/root/Level 1/TileMap')
	GlobalSignals.update_fuel_remaining.connect(_update_fuel_remaining)

func _is_hero_touching_pipe_entrance(hero):
	var local_position = tile_map.to_local(hero.global_position)
	var tile_coords = tile_map.local_to_map(local_position)
	var data = tile_map.get_cell_tile_data(1, tile_coords)
	
	if (data):
		return data.get_custom_data("power") == "pipe"
	
	return false

func _detect_pipe_collision():
	var hero: CharacterBody2D = get_node("/root/Level 1/Hero")
	if !self._is_hero_touching_pipe_entrance(hero):
		return

	var sound: AudioStreamPlayer2D = $SoundPipe
	if (!sound.playing):
		sound.play()

func _update_fuel_remaining(fuel_left):
	fuel_to_burn = fuel_left
	
func _process(delta):
	self._detect_pipe_collision()
	
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


