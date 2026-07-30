class_name Enemy_Red
extends CharacterBody2D

var speed: float = 200.0
var player: CharacterBody2D
var health: int = 100

@export var health_ui: ProgressBar
@export var sprite: Sprite2D

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = Vector2(1, 0).rotated(rotation) * speed
		move_and_slide()

		if can_shoot:
			_shoot()

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


func _shoot() -> void:
	print("Enemy shooting")

	if bullet_scene == null or bullet_spawn == null:
		return

	var bullet = bullet_scene.instantiate()
	print("Bullet created:", bullet)

	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation

	get_parent().add_child(bullet)

	can_shoot = false

	await get_tree().create_timer(2.0).timeout
	can_shoot = true
