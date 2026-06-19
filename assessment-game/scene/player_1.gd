extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0  # Define your own gravity

@export var sprite: Sprite2D
@export var score_label: Label  # ADDED

var double_jump = true  # Track double jump
var score: int = 0  # ADDED

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump = true  # Reset double jump when touching the floor

	# Handle jump
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			double_jump = true
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false

	# Handle horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move the character
	move_and_slide()

extends CharacterBody2D

var speed: float = 400.0
var health: int = 10
var can_shoot: bool = true
var score: int = 0

@export var pivot: Node2D
@export var bullet_spawn: Marker2D
@export var bullet_scene: PackedScene
@export var health_ui: ProgressBar
@export var bullet_timer: Timer
@export var score_label: Label

func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health
	score_label.text = "SCORE: " + str(score)
	
func _process(delta: float) -> void:
	var direction: Vector2 = Vector2(0.0, 0.0)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	velocity = speed * direction.normalized()
	
	pivot.look_at(get_global_mouse_position())
			
	move_and_slide()
 
	if Input.is_action_pressed("ui_shoot") and can_shoot:
		_shoot()
	
	move_and_slide()

func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = pivot.rotation
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	can_shoot = false
	bullet_timer.start()
	
func take_damage() -> void:
	if health > 1:
		health -= 1
		health -= 1
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")

func _bullet_cooldown() -> void:
	can_shoot = true

func add_score(amount: int) -> void:
	score += amount
	score_label.text = "SCORE: " + str(score)
	print("Score:", score)
