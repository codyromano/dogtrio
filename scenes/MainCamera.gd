extends Camera2D

@onready var hero: CharacterBody2D
@onready var viewport: Viewport

# The player's overall speed (sum of X and Y velocities)
var speed: float = 0

# The player speed at which the camera is fully zooomed out
const max_speed: float = 75

# Zoom properties
const zoom_speed: float = 0.50
const max_zoom_out: float = 5
# const max_zoom_in: float = 6
const max_zoom_in: float = 6.5
const initial_zoom: Vector2 = Vector2(max_zoom_in, max_zoom_in)

# Called when the node enters the scene tree for the first time.
func _ready():
	hero = get_node('/root/Level 1/Hero')
	viewport = get_viewport()
	zoom = initial_zoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hero:
		var velocity = hero.get_real_velocity()
		speed = clamp(abs(velocity.x) + abs(velocity.y), 0, max_speed)
		
		var mapping = remap(speed, 0, max_speed, max_zoom_in, max_zoom_out)
		zoom = lerp(zoom, Vector2(mapping, mapping), zoom_speed * delta)

