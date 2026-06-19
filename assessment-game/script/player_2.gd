extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0  # Define your own gravity

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

var health: int = 100

var double_jump = true  # Track double jump

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
