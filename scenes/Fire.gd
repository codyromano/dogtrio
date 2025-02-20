extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tween: Tween = create_tween()
	
	if Input.is_action_pressed("fart"):
		tween.tween_property(self, "modulate:a", 1, 0.25)
	else:
		tween.tween_property(self, "modulate:a", 0, 0.5)
