extends Node2D

const LEVEL_2_SCENE = "res://scene/Level 2.tscn"
const PLAYER_GROUP = "player"


# Teleports the user to the next level
func _level_portal(body: Node2D) -> void:
	if body.is_in_group(PLAYER_GROUP):
		get_tree().change_scene_to_file(LEVEL_2_SCENE)
