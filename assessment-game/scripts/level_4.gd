extends Node2D

const PLAYER_GROUP = "player"
const ENDING_SCENE = "res://scene/Ending_scene.tscn"


func _ready() -> void:
	pass


# Called every frame while the level is active.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Changes levels when a player enters the portal.
	if body.is_in_group(PLAYER_GROUP):
		get_tree().change_scene_to_file(ENDING_SCENE)
