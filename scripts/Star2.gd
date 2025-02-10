extends Area2D

var is_collected: bool = false
	
func _on_star_disappeared():
	$Star2Sprite.queue_free()
	GlobalSignals.star_collected.emit()

func _on_body_entered(body):
	if is_collected:
		return
	
	is_collected = true
	
	$SoundStar.play()
	# $Star2Sprite.visible = false
	#  $Star2Sprite.apply_scale(Vector2(1.5, 1.5))
	
	var target_node = get_node("/root/Level 1/ScoreUI")
	
	var tween = create_tween()
	tween.tween_property(
		$Star2Sprite,
		"position",
		target_node.position,
		2.0
	) # Moves in 2 seconds
	
	tween.connect("finished", _on_star_disappeared)
