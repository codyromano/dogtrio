extends Label

var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.star_collected.connect(_on_star_collected)

func _on_star_collected():
	score += 1
	text = str(score)
	
