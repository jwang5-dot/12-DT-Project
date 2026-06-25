class_name Enemy_Red
extends CharacterBody2D

var speed: float = 200.0
var player: CharacterBody2D
var health: int = 100

@export var health_ui: ProgressBar
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1, 0).rotated(rotation) * speed
		move_and_slide()

func take_damage() -> void:
	if health > 1:
		health -= 5
		health_ui.value = health
	else: 
		queue_free()

func _take_damage(body: Node2D) -> void:
	if body is Player_1:
		body.take_damage()
