extends CanvasLayer

func get_position():
	var viewport = get_viewport()
	var upper_right = Vector2(viewport.get_visible_rect().end.x, 0)
	# var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D", true, false)
	return upper_right
