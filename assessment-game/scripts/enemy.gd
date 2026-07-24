class_name Enemy_Black
extends CharacterBody2D

var speed: float = 200.0
var player: CharacterBody2D
var health: int = 100

@export var health_ui: ProgressBar
@export var sprite: Sprite2D
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

	if health_ui:
		health_ui.max_value = health
		health_ui.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1, 0).rotated(rotation) * speed
		move_and_slide()
	health_ui.get_parent().rotation = -rotation
	sprite.global_rotation = 0

func take_damage() -> void:
	if health > 1:
		health -= 5
		health_ui.value = health
	else: 
		queue_free()

func _take_damage(body: Node2D) -> void:
	if body is Player_1:
		body.take_damage()
