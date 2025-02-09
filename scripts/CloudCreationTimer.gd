extends Timer

@onready var cloud_scene

func _ready():
	cloud_scene = preload("res://scenes/cloud.tscn")

func _on_timeout():
	var cloud = cloud_scene.instantiate()
	# cloud.position = Vector2(0, randi_range(100, 150))  # Set position
	add_child(cloud)
	
