class_name Melee_Enemy
extends CharacterBody2D

const SPEED = 200.0
const DAMAGE_INTERVAL := 0.5

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100
var player: CharacterBody2D
var damage_timer := 0.0
var Player: Player_2 = null

func _physics_process(delta: float) -> void:
	if Player == null:
		return
	damage_timer -= delta

	if damage_timer <= 0:
		Player.take_damage()
		damage_timer = DAMAGE_INTERVAL

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node
	health_ui.max_value = health
	health_ui.value = health

func _process(delta: float) -> void:
		if not player == null:
			look_at(player.global_position)
			velocity = Vector2(1, 0).rotated(rotation) * SPEED
			move_and_slide()
		health_ui.get_parent().rotation = -rotation
		sprite.global_rotation = 0

func take_damage() -> void:
	if health > 1:
		health -= 10
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")

func _take_damage(body: Node2D) -> void:
	if body is Player_2:
		player = body
	if body is Player_2:
		body.take_damage()
