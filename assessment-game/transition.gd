extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var transitioning = false


func transition_to(scene_path: String) -> void:
	if transitioning:
		return

	transitioning = true

	# Fade to black
	animation_player.play("fade_out")
	await animation_player.animation_finished

	# Change scene while screen is black
	get_tree().change_scene_to_file(scene_path)

	# Fade from black back to visible
	animation_player.play("fade_in")
	await animation_player.animation_finished

	transitioning = false
