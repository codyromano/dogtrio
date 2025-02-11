extends ProgressBar

var max_fuel: float = 50
var fuel_spent: float = 0
var fuel_regen: float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	GlobalSignals.spend_fuel.connect(_on_spend_fuel)
	GlobalSignals.capability_unlocked_fart.connect(_on_unlock_jetpack)
	pass # Replace with function body.

func _on_unlock_jetpack():
	var tween: Tween = create_tween() 
	tween.tween_property(self, "modulate:a", 1, 1)
	
func _on_spend_fuel(_temp):
	fuel_spent = clamp(fuel_spent + 1, 0, max_fuel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = remap(fuel_spent, 0, max_fuel, 100, 0)
	fuel_spent = clamp(fuel_spent - fuel_regen, 0, max_fuel)
	GlobalSignals.update_fuel_remaining.emit(value)
