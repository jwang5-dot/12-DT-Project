extends Control


func _play() -> void:
	Transition.transition_to("res://scene/Level_1_scene.tscn")


func _quit() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/controls.tscn")
