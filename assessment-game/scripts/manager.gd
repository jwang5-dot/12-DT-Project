extends Node2D

@export var spawn_point: PathFollow2D
@export var enemy_scene: PackedScene


func _spawn_enemy() -> void:
	spawn_point.progress_ratio = randf_range(0.0, 1.0)
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	add_child(enemy)
