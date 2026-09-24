class_name Melee_Enemy
extends CharacterBody2D

const SPEED = 200.0
const MOVE_LEFT: float = -1
const MOVE_RIGHT: float = 1
const STOP: float = 0
const CONTINUOUS_DAMAGE_TIMER: float = 0.5
const DAMAGE_DONE: int = 5
const DAMAGE_TAKEN: int = 10
const CONTINUOUS_DAMAGE: int = 1

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100
var player: CharacterBody2D
var direction = STOP
var continuous_damage_count_down = 0.5
var player_range: bool = false


# Checks if player is in-range with enemy and does continuous damage
func _physics_process(delta: float) -> void:
	if player_range == true:
		continuous_damage_count_down -= delta
	if continuous_damage_count_down < 0:
		player.take_damage(CONTINUOUS_DAMAGE)
		continuous_damage_count_down = CONTINUOUS_DAMAGE_TIMER


# Sets enemy at maximum health and finds player at the start
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node
	health_ui.max_value = health
	health_ui.value = health


# Moves towards the player from player's global position
func _process(delta: float) -> void:
	if player == null:
		return
	if player.global_position.x > global_position.x:
		direction = MOVE_RIGHT
	elif player.global_position.x < global_position.x:
		direction = MOVE_LEFT
	velocity = Vector2(direction * SPEED, 1.0)
	move_and_slide()


# Checks if enemy still has health to take damage
# Deletes enemy from scene when no health
func take_damage() -> void:
	if health > 1:
		health -= DAMAGE_TAKEN
		health_ui.value = health
	else: 
		queue_free()


# Checks if the the body interacted is Player and deals damage
func _take_damage(body: Node2D) -> void:
	if body is Player_2 or body is Player_1:
		body.take_damage(DAMAGE_DONE)
		player_range = true


# Checks so the player dosen't take damage when not interacting with enemy
func _exit_body(body: Node2D) -> void:
	player_range = false
