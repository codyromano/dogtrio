extends Node2D

func _ready():
	GlobalSignals.capability_unlocked_fart.connect(_on_fart_unlocked)

func _on_fart_unlocked():
	queue_free()
