extends Node2D


# Called when the level enters the scene tree for the first time.
func _ready() -> void:
	pass # No code is currently required when the level starts.


# Called every frame while the level is active.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	# Checks that the entered area belongs to the player before ending the level.
	if area.is_in_group("player"):
		get_tree().change_scene_to_file("res://scene/Ending_scene.tscn")
