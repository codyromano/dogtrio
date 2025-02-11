extends Area2D

var is_collected: bool = false

func _on_star_collected_custom_impl():
	pass
	
func _on_star_disappeared():
	$AnimatedSprite2D.queue_free()
	GlobalSignals.star_collected.emit()
	_on_star_collected_custom_impl()

func _on_body_entered(_body):
	if is_collected:
		return
	
	is_collected = true
	
	$SoundStar.play()
	# $AnimatedSprite2D.visible = false
	#  $AnimatedSprite2D.apply_scale(Vector2(1.5, 1.5))
	
	# var score_ui_node = get_node("/root/Level 1/ScoreUI")
	
	var camera = get_viewport().get_camera_2d()
	var center_position = camera.get_screen_center_position()
	
	var upper_right = Vector2(
		center_position.x + 250, 
		$AnimatedSprite2D.position.y - 250
	)
	
	var tween = create_tween()
	
	tween.tween_property(
		$AnimatedSprite2D,
		"scale",
		Vector2(1.75, 1.75),
		1
	)
	
	tween.tween_property(
		$AnimatedSprite2D,
		"position",
		upper_right,
		2
	) # Moves in 2 seconds
	
	tween.connect("finished", _on_star_disappeared)
