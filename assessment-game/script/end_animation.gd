extends Node2D


# Ends the game when the animation finishes
func _animation_finished() -> void:
	get_tree().quit()
