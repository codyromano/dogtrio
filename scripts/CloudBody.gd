extends StaticBody2D

@export var move_time: float = 200  # Time to move out of view

var tween: Tween

func _ready():
	position.y = -20
	move_out_of_view()

func move_out_of_view():
	var viewport_rect = get_viewport_rect()
	var exit_position = Vector2(viewport_rect.size.x + 100, position.y)  # Move past the right edge
	
	tween = get_tree().create_tween()
	tween.tween_property(
		self,
		"position",
		exit_position, 
		move_time
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

	tween.finished.connect(queue_free)  
