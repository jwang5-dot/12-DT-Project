class_name Player_1
extends CharacterBody2D

# Stores the values used to control the player's movement.
const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0

# Stores whether the player can perform a second jump.
var double_jump = true

# Stores the player's current health.
var health: int = 100

# Counts how many times the player has used a portal.
var teleport_count: int = 0

# Prevents the player from shooting while the shooting cooldown is active.
var can_shoot: bool = true

# References the nodes used for the player's appearance, aiming, shooting and health.
@export var sprite: Sprite2D
@export var score_label: Label
@export var pivot: Node2D
@export var bullet_spawn: Marker2D
@export var bullet_scene: PackedScene
@export var health_ui: ProgressBar

func _ready() -> void:
	# Sets the health bar's maximum and current values to the player's health.
	if health_ui:
		health_ui.max_value = health
		health_ui.value = health


func _physics_process(delta: float) -> void:

	# Applies gravity while the player is not on the floor.
	# The double jump is reset when the player lands.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump = true

	# Checks for the jump input and allows the player to jump or double jump.
	if Input.is_action_just_pressed("ui_W"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false

	# Gets the player's horizontal movement input.
	var direction := Input.get_axis("ui_A", "ui_D")

	# Moves the player in the chosen direction or slows the player when there is no input.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Rotates the weapon towards the mouse position so the player can aim.
	if pivot:
		pivot.look_at(get_global_mouse_position())

	# Checks whether the player is shooting and whether shooting is currently allowed.
	if Input.is_action_pressed("ui_shoot") and can_shoot:
		_shoot()

	# Moves the player using the calculated velocity.
	move_and_slide()

func _shoot() -> void:
	# Stops the function if no bullet scene has been assigned.
	if bullet_scene == null:
		return

	# Creates a bullet and places it at the bullet spawn position.
	var bullet = bullet_scene.instantiate()
	bullet.rotation = pivot.rotation
	bullet.global_position = bullet_spawn.global_position

	add_sibling(bullet)

	# Prevents another bullet from being fired during the shooting cooldown.
	can_shoot = false

	# Waits for the cooldown before allowing the player to shoot again.
	await get_tree().create_timer(0.2).timeout
	can_shoot = true
	

func take_damage(amount: int) -> void:
	# Checks that the damage value is valid before applying it.
	if amount <= 0:
		return

	# Reduces the player's health when the player has enough health remaining.
	if health > amount:
		health -= amount
		health_ui.value = health
	else:
		# Sets health to zero so it cannot become negative at the boundary.
		health = 0
		health_ui.value = health
		
		# Reloads the current scene when the player's health reaches zero.
		get_tree().reload_current_scene()


func _melee_damage(body: Node2D) -> void:
	# Checks whether the body is a red enemy before dealing melee damage.
	if body is Enemy_Red:
		body.take_damage()
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks that the body entering the area is the player before ending the level.
	if body is Player_1:
		get_tree().change_scene_to_file("res://scene/Ending_scene.tscn")
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Checks whether the area belongs to the Portal group before teleporting.
	if area.is_in_group("Portal"):
		position.x = 61
		position.y = 598
		teleport_count += 1

		# Changes to the ending animation after the portal is used twice.
		if teleport_count >= 2:
			get_tree().change_scene_to_file("res://scene/End_Animation.tscn")
