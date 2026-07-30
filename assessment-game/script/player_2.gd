class_name Player_2
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0  
const Continuous_Damage_Timer: float = 0.5

var health: int = 100
var double_jump: bool = true 
var enemy: Melee_Enemy
var teleport_count: int = 0
var enemy_range: bool = false
var damage_timer = Continuous_Damage_Timer

@export var sprite: Sprite2D
@export var health_ui: ProgressBar

func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health

func _physics_process(delta: float) -> void:
	if enemy_range:
		damage_timer -= delta
	if damage_timer < 0:
		enemy.take_damage()
		damage_timer = Continuous_Damage_Timer
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump = true  

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
	
func take_damage() -> void:
	if health > 1:
		health -= 10
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")


func _attack(body: Node2D) -> void:
	if body is Melee_Enemy:
		enemy = body 
		enemy_range = true


func _portal(area: Area2D) -> void:
	if area.is_in_group("Portal"):
		position.x = 61
		position.y = 598
		teleport_count += 1
		if teleport_count >= 2:
			get_tree().change_scene_to_file("res://scene/End_Animation.tscn")
