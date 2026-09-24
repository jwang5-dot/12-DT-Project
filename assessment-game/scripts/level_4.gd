extends Node2D


func _ready() -> void:
	pass 


# Called every frame while the level is active.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Changes levels when a player enters the portal.
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scene/Ending_scene.tscn")
