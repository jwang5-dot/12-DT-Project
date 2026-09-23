extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var transitioning = false


func transition_to(scene_path: String) -> void:
	if transitioning:
		return

	transitioning = true	

	animation_player.play("fade_out")
	await animation_player.animation_finished

	get_tree().change_scene_to_file(scene_path)

	# Fades the screen back in to show the new scene.
	animation_player.play("fade_in")
	await animation_player.animation_finished

	transitioning = false
