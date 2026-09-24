extends Control

const LEVEL_1_SCENE = "res://scene/Level_1_scene.tscn"
const CONTROLS_SCENE = "res://scene/controls.tscn"
const CREDITS_SCENE = "res://scene/credits.tscn"


func _play() -> void:
	# Starts the game by transitioning to the first level.
	Transition.transition_to(LEVEL_1_SCENE)


func _quit() -> void:
	# Closes the game when the quit button is pressed.
	get_tree().quit()


func _on_button_pressed() -> void:
	# Opens the controls screen when the controls button is pressed.
	Transition.transition_to(CONTROLS_SCENE)


func _on_button_2_pressed() -> void:
	# Opens the credits screen when the credits button is pressed.
	Transition.transition_to(CREDITS_SCENE)
