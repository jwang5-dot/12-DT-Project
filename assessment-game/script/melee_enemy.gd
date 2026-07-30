class_name Melee_Enemy
extends CharacterBody2D

const SPEED = 200.0
const MOVE_LEFT: float = -1
const MOVE_RIGHT: float = 1
const STOP: float = 0
const Continuous_Damage_Timer: float = 0.5

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100
var player: CharacterBody2D
var direction = STOP
var damage_timer = Continuous_Damage_Timer
var player_range: bool = false

func _physics_process(delta: float) -> void:
	if player_range:
		damage_timer -= delta
	if damage_timer < 0:
		player.take_damage()
		damage_timer = Continuous_Damage_Timer 


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
		get_tree().call_deferred("reload_current_scene")

func _take_damage(body: Node2D) -> void:
	if body is Player_2:
		body.take_damage()
		player_range = true
