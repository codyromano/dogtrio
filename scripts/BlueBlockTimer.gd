extends Timer
	
func _on_timeout():
	$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
