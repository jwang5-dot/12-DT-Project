class_name Melee_Enemy
extends CharacterBody2D

const SPEED = 200.0

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100
var player: CharacterBody2D

func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health


func take_damage() -> void:
	if health > 1:
		health -= 10
	else:
		queue_free()
s
func _take_damage(body: Node2D) -> void:
	if body is Player_2:
		body.take_damage()
