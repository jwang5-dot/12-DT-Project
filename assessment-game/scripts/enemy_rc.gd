class_name Enemy_Red
extends CharacterBody2D

# Stores the enemy's movement speed, target player, health and contact damage.
var speed: float = 200.0
var player: CharacterBody2D
var health: int = 850
var damage_contact: int = 5

# References the enemy's health bar and sprite.
@export var health_ui: ProgressBar
@export var sprite: Sprite2D

# References the two points used to define the enemy's movement area.
@export var point_a: Marker2D
@export var point_b: Marker2D

# Stores the random position that the enemy is currently moving towards.
var target_position: Vector2

# Stores the bullet scene, bullet spawn point and whether the enemy can shoot.
@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
var can_shoot: bool = true
		
# Called when the enemy enters the scene tree for the first time.
func _ready() -> void:
	# Searches the player group to find the player that the enemy will target.
	for node in get_tree().get_nodes_in_group("player"):
		player = node

	# Finds the first movement point if it has not already been assigned.
	if point_a == null:
		point_a = get_tree().get_first_node_in_group('point_a')

	# Finds the second movement point if it has not already been assigned.
	if point_b == null:
		point_b = get_tree().get_first_node_in_group('point_b')

	# Sets the health bar to match the enemy's starting health.
	if health_ui:
		health_ui.max_value = health
		health_ui.value = health

	# Selects the enemy's first random movement destination.
	pick_random_point()


func pick_random_point() -> void:
	# Stops the function if either movement point is missing.
	if point_a == null or point_b == null:
		return

	# Generates a random position between the two movement points.
	target_position = Vector2(
		randf_range(point_a.global_position.x, point_b.global_position.x),
		randf_range(point_a.global_position.y, point_b.global_position.y)
	)

# Called every frame while the enemy is active.
func _process(delta: float) -> void:
	# Selects a new random destination when the enemy gets close to its current target.
	if global_position.distance_to(target_position) < 10:
		pick_random_point()

	# Moves the enemy towards its selected random destination.
	velocity = (target_position - global_position).normalized() * speed
	move_and_slide()

	# Makes the enemy face the player and shoot when shooting is available.
	if player:
		look_at(player.global_position)

		if can_shoot:
			_shoot()

	# Keeps the health bar facing correctly while the enemy rotates.
	if health_ui:
		health_ui.get_parent().rotation = -rotation

	# Keeps the enemy sprite upright while the enemy rotates.
	if sprite:
		sprite.global_rotation = 0


func take_damage() -> void:
	# Reduces the enemy's health while more than one health remains.
	if health > 1:
		health -= 3
		health_ui.value = health
	else: 
		# Removes the enemy from the scene when its health reaches one or less.
		queue_free()		


func _take_damage(body: Node2D) -> void:
	# Checks that the colliding body is a player before applying contact damage.
	if body is Player_1 or body is Player_2:
		body.take_damage(damage_contact)


func _shoot() -> void:

	# Stops the function if the bullet scene or spawn point is missing.
	if bullet_scene == null or bullet_spawn == null:
		return

	# Creates a bullet and sets its damage, position and rotation.
	var bullet = bullet_scene.instantiate()
	bullet.damage = 30

	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation

	get_parent().add_child(bullet)

	# Prevents the enemy from shooting again during the shooting cooldown.
	can_shoot = false

	# Waits for the cooldown before allowing the enemy to shoot again.
	await get_tree().create_timer(2.0).timeout
	can_shoot = true
