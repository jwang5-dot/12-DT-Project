extends Node2D


func _ready() -> void:
	pass 


# Called every frame while the level is active.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to_file("res://scene/Ending_scene.tscn")
