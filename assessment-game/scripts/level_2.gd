extends Node2D

const PLAYER_GROUP = "player"
const LEVEL_3_SCENE = "res://scene/Level_3_scene.tscn"


# Called when the level enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Changes levels when a player enters the portal.
	if body.is_in_group(PLAYER_GROUP):
		get_tree().change_scene_to_file(LEVEL_3_SCENE)
