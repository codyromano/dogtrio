extends "res://scripts/Star2.gd"

func _on_star_collected_custom_impl():
	GlobalSignals.capability_unlocked_fart.emit()
