extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property($FartInstructions, "modulate:a", 0.0, 0)
	GlobalSignals.capability_unlocked_fart.connect(_on_fart_unlocked)


func _on_fart_unlocked():
	var tween = create_tween()
	tween.tween_property($RunJumpInstructions, "modulate:a", 0, 0.5)
	tween.chain().tween_property($FartInstructions, "modulate:a", 1, 1.5)
