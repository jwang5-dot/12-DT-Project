extends CharacterBody2D

const SPEED = 200.0

@export var sprite: Sprite2D
@export var health_bar: ProgressBar

var health: int = 100
var player: CharacterBody2D

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("Player_2"):
		player = node

func take_damage() -> void:
	if health > 1:
		health -= 1
	else:
		queue_free()

func _take_damage(body: Node2D) -> void:
	if body == player:
		player.take_damage(10)
