extends Area2D

var is_spring_depressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body: Node2D):
	is_spring_depressed = true
	
	$SpringBox/AnimatedSprite2D.play("press_down")
	
	if body.has_method("super_jump"):
		body.super_jump()

# func _on_body_exited(_body):
	# $SpringBox/AnimatedSprite2D.play_backwards("press_down")
	
func _on_animated_sprite_2d_animation_finished():
	if is_spring_depressed:
		$SpringBox/AnimatedSprite2D.play_backwards("press_down")
		is_spring_depressed = false
