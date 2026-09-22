extends Node2D


# Called when the level enters the scene tree for the first time.
func _ready() -> void:
	pass # No code is currently required when the level starts.


# Called every frame while the level is active.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	# No action is currently required when an area exits this trigger.
	pass # No code is currently required for this signal.


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Changes to Level 3 when a body enters the level transition area.
	get_tree().change_scene_to_file("res://scene/Level_3_scene.tscn")
