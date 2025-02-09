extends StaticBody2D

var blink_timer: Timer
var make_visible_timer: Timer

func _ready():
	GlobalSignals.blue_switch_toggle_on.connect(
		_on_blue_switch_toggle_on
	)
	# For debugging only
	# _on_blue_switch_toggle_on()

func _on_blue_switch_toggle_on():
	$CollisionShape2D.call_deferred("set_disabled", true)
	
	# Create a timer to make the blue block blink
	blink_timer = Timer.new()
	blink_timer.wait_time = 0.5  # Blink twice per second
	blink_timer.autostart = true
	blink_timer.one_shot = false  # Make it repeat
	blink_timer.timeout.connect(_on_blink_timer_timeout)
	add_child(blink_timer)
	
	# Create a timer to make the blue block stop blinking
	make_visible_timer = Timer.new()
	make_visible_timer.wait_time = 10
	make_visible_timer.autostart = true
	make_visible_timer.one_shot = true
	make_visible_timer.timeout.connect(_on_make_visible_timer_timeout)
	add_child(make_visible_timer)

func _on_blink_timer_timeout():
	visible = !visible  # Toggle visibility
	
func _on_make_visible_timer_timeout():
	$CollisionShape2D.call_deferred("set_disabled", false)
		
	visible = true
	remove_child(blink_timer)
	remove_child(make_visible_timer)
	
	make_visible_timer = null
	blink_timer = null
	
	GlobalSignals.blue_switch_toggle_off.emit()

