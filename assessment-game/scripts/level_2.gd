extends Node2D


# Called when the level enters the scene tree for the first time.
func _ready() -> void:
	pass # No code is currently required when the level starts.


func _process(delta: float) -> void:
	pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass 


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks that the body entering the area is Player 1 before changing levels.
	if body is Player_1:
		get_tree().change_scene_to_file("res://scene/Level_3_scene.tscn")
