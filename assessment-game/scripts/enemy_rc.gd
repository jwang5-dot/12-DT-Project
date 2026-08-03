class_name Enemy_Red
extends CharacterBody2D

var speed: float = 200.0
var player: CharacterBody2D
var health: int = 100

@export var health_ui: ProgressBar
@export var sprite: Sprite2D

@export var point_a: Marker2D
@export var point_b: Marker2D

var target_position: Vector2

# Shooting
@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
var can_shoot: bool = true
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

	if health_ui:
		health_ui.max_value = health
		health_ui.value = health

	pick_random_point()


func pick_random_point() -> void:
	if point_a == null or point_b == null:
		return

	target_position = Vector2(
		randf_range(point_a.global_position.x, point_b.global_position.x),
		randf_range(point_a.global_position.y, point_b.global_position.y)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.distance_to(target_position) < 10:
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
		health -= 3
		health_ui.value = health
	else: 
		queue_free()


func _take_damage(body: Node2D) -> void:
	if body is Player_1:
		body.take_damage()


func _shoot() -> void:

	if bullet_scene == null or bullet_spawn == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.damage = 30

	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation

	get_parent().add_child(bullet)

	can_shoot = false

	await get_tree().create_timer(2.0).timeout
	can_shoot = true
