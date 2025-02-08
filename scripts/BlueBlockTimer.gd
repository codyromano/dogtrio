extends Timer

@onready var collision_box: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_box = $CollisionShape2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collision_box:
		print("ok")
		# Allow passthrough of blue blocks while timer is running
		collision_box.set_disabled(!is_stopped())
	else:
		print("foobar")
	
func _on_timeout():
	$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
