extends Control


func _play() -> void:
	# Starts the game by transitioning to the first level.
	Transition.transition_to("res://scene/Level_1_scene.tscn")


func _quit() -> void:
	# Closes the game when the quit button is pressed.
	get_tree().quit()


func _on_button_pressed() -> void:
	# Opens the controls screen when the controls button is pressed.
	Transition.transition_to("res://scene/controls.tscn")


func _on_button_2_pressed() -> void:
	# Opens the credits screen when the credits button is pressed.
	Transition.transition_to("res://scene/credits.tscn")
