extends CanvasLayer

const FADE_OUT_ANIMATION = "fade_out"
const FADE_IN_ANIMATION = "fade_in"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var transitioning = false


func transition_to(scene_path: String) -> void:
	if transitioning:
		return

	transitioning = true

	animation_player.play(FADE_OUT_ANIMATION)
	await animation_player.animation_finished

	get_tree().change_scene_to_file(scene_path)

	# Fades the screen back in to show the new scene.
	animation_player.play(FADE_IN_ANIMATION)
	await animation_player.animation_finished

	transitioning = false
