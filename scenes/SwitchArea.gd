extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Node2D):
	var sprite: AnimatedSprite2D = $AnimatedSprite2D
	if (sprite.animation != "default" || sprite.is_playing()):
		return
	
	var current_animation: String = sprite.animation;
	
	sprite.play(
		"toggled_on" if current_animation == "default" else "default"
	)

