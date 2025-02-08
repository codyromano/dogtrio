extends Area2D

@onready var sprite: AnimatedSprite2D
var is_toggle_on: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $AnimatedSprite2D
	GlobalSignals.blue_switch_toggle_off.connect(_on_blue_switch_toggle_off)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_blue_switch_toggle_off():
	sprite.play_backwards("toggled_on")
	is_toggle_on = false

func _on_body_entered(_body: Node2D):
	if is_toggle_on:
		return
		
	GlobalSignals.blue_switch_toggle_on.emit()
	is_toggle_on = true

