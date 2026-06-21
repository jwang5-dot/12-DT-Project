extends Control


func _play() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/level.tscn")



func _quit() -> void:
	get_tree().quit()
