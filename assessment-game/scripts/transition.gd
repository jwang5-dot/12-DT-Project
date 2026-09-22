extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var transitioning = false


func transition_to(scene_path: String) -> void:
	# Stops the function if a scene transition is already in progress.
	if transitioning:
		return

	# Marks the transition as active to prevent multiple transitions at once.
	transitioning = true	

	# Fades the screen to black before changing scenes.
	animation_player.play("fade_out")
	await animation_player.animation_finished

	# Changes to the selected scene while the screen is black.
	get_tree().change_scene_to_file(scene_path)

	# Fades the screen back in to show the new scene.
	animation_player.play("fade_in")
	await animation_player.animation_finished

	# Allows another scene transition to begin.
	transitioning = false
