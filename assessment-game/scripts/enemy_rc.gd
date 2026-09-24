class_name Enemy_Red
extends CharacterBody2D

const TARGET_DISTANCE = 10
const DAMAGE_PER_HIT = 3
const BULLET_DAMAGE = 30
const SHOOT_COOLDOWN = 2.0

# Stores the group names used to find the player and movement points.
const PLAYER_GROUP = "player"
const POINT_A_GROUP = "point_a"
const POINT_B_GROUP = "point_b"

# Stores the enemy's movement speed, target player, health and contact damage.
var speed: float = 200.0
var player: CharacterBody2D
var health: int = 650
var damage_contact: int = 5

@export var health_ui: ProgressBar
@export var sprite: Sprite2D

@export var point_a: Marker2D
@export var point_b: Marker2D

var target_position: Vector2

@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
var can_shoot: bool = true


func _ready() -> void:
	for node in get_tree().get_nodes_in_group(PLAYER_GROUP):
		player = node

	if point_a == null:
		point_a = get_tree().get_first_node_in_group(POINT_A_GROUP)

	if point_b == null:
		point_b = get_tree().get_first_node_in_group(POINT_B_GROUP)

	if health_ui:
		health_ui.max_value = health
		health_ui.value = health
	pick_random_point()


func pick_random_point() -> void:
	if point_a == null or point_b == null:
		return

	# Generates a random position between the two movement points.
	target_position = Vector2(
		randf_range(point_a.global_position.x, point_b.global_position.x),
		randf_range(point_a.global_position.y, point_b.global_position.y)
	)


func _process(delta: float) -> void:
	if global_position.distance_to(target_position) < TARGET_DISTANCE:
		pick_random_point()

	velocity = (target_position - global_position).normalized() * speed
	move_and_slide()

	if player:
		look_at(player.global_position)

		if can_shoot:
			_shoot()

	if health_ui:
		health_ui.get_parent().rotation = -rotation

	if sprite:
		sprite.global_rotation = 0


func take_damage() -> void:
	if health > 1:
		health -= DAMAGE_PER_HIT
		health_ui.value = health
	else:
		queue_free()


func _take_damage(body: Node2D) -> void:
	if body is Player_1 or body is Player_2:
		body.take_damage(damage_contact)


func _shoot() -> void:
	if bullet_scene == null or bullet_spawn == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.damage = BULLET_DAMAGE

	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation

	get_parent().add_child(bullet)

	can_shoot = false

	# Waits for the cooldown before allowing the enemy to shoot again.
	await get_tree().create_timer(SHOOT_COOLDOWN).timeout
	can_shoot = true
