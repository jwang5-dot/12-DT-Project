extends Control


func _play() -> void:
	get_tree().change_scene_to_file("res://scene/Level_1_scene.tscn")

func _quit() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	pass # Replace with function body.
