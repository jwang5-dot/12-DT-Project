extends CharacterBody2D

# Movement
const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0

var double_jump = true

# Health
var health: int = 10

# Score
var score: int = 0

# Shooting
var can_shoot: bool = true

@export var sprite: Sprite2D
@export var score_label: Label
@export var pivot: Node2D
@export var bullet_spawn: Marker2D
@export var bullet_scene: PackedScene
@export var health_ui: ProgressBar

func _ready() -> void:
	if health_ui:
		health_ui.max_value = health
		health_ui.value = health

	if score_label:
		score_label.text = "SCORE: " + str(score)

func _physics_process(delta: float) -> void:

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump = true

	# Jumping
	if Input.is_action_just_pressed("ui_W"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false

	# Horizontal movement
	var direction := Input.get_axis("ui_A", "ui_D")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Aim weapon at mouse
	if pivot:
		pivot.look_at(get_global_mouse_position())

	# Shoot
	if Input.is_action_pressed("ui_shoot") and can_shoot:
		_shoot()

	move_and_slide()

func _shoot() -> void:
	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.rotation = pivot.rotation
	bullet.global_position = bullet_spawn.global_position

	add_sibling(bullet)

	can_shoot = false

func _bullet_cooldown() -> void:
	can_shoot = true

func take_damage() -> void:
	if health > 1:
		health -= 1

		if health_ui:
			health_ui.value = health
	else:
		get_tree().reload_current_scene()

func add_score(amount: int) -> void:
	score += amount

	if score_label:
		score_label.text = "SCORE: " + str(score)

	print("Score:", score)
