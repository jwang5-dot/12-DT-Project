class_name Melee_Enemy
extends CharacterBody2D

const SPEED = 200.0
const MOVE_LEFT: float = -1
const MOVE_RIGHT: float = 1
const STOP: float = 0
const CONTINUOUS_DAMAGE_TIMER: float = 0.5

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100
var player: CharacterBody2D
var direction = STOP
var continuous_damage_count_down = 0.5
var player_range: bool = false

func _physics_process(delta: float) -> void:
	if player_range == true:
		continuous_damage_count_down -= delta
	if continuous_damage_count_down < 0:
		player.take_damage(1)
		continuous_damage_count_down = CONTINUOUS_DAMAGE_TIMER

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node
	health_ui.max_value = health
	health_ui.value = health

func _process(delta: float) -> void:
		if player == null:
			return
		if player.global_position.x > global_position.x:
			direction = MOVE_RIGHT
		elif player.global_position.x < global_position.x:
			direction = MOVE_LEFT
		velocity = Vector2(direction * SPEED, 1.0)
		move_and_slide()

func take_damage() -> void:
	if health > 1:
		health -= 10
		health_ui.value = health
	else: 
		queue_free()

func _take_damage(body: Node2D) -> void:
	if body is Player_2 or body is Player_1:
		body.take_damage(5)
		player_range = true


func _exit_body(body: Node2D) -> void:
	player_range = false
