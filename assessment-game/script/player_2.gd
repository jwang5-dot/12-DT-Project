class_name Player_2
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
const GRAVITY = 1200.0  
const Continuous_Damage_Timer: float = 0.5
const TELEPORT_XVALUE = 61
const TELEPORT_YVALUE = 598
const SHIELD_COOLDOWN: float = 2.0
const SHIELD_DURATIOM: float = 4.0
const SHIELD_REGENERATION: float = 1.5
const TELEPORT_REQUIRMENT: int = 2

var health: int = 100
var double_jump: bool = true 
var enemy: CharacterBody2D
var teleport_count: int = 0
var enemy_range: bool = false
var damage_timer = Continuous_Damage_Timer
var shielding: bool = false
var teleport_increase: int = 1
var shield_time: float = SHIELD_DURATIOM
var shield_cooldown_time: float = 0.0
var shield_regeneration_time: float = 0.0

@export var sprite: Sprite2D
@export var health_ui: ProgressBar
@export var show_shielding: Sprite2D
@export var shielding_bar: ProgressBar


# Player starts with Maximum health and shield bar
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health 
	show_shielding.visible = false
	shielding_bar.max_value = SHIELD_DURATIOM
	shielding_bar.value = SHIELD_DURATIOM


func _physics_process(delta: float) -> void:
	# Checks if enemy is in range and reduces the timer
	if enemy_range == true:
		damage_timer -= delta
		
	# Enemy takes damage after time
	if damage_timer < 0:
		enemy.take_damage()
		damage_timer = Continuous_Damage_Timer
		
# Shield cooldown
	if shield_cooldown_time > 0:
		shield_cooldown_time -= delta

	# Shield regeneration
	if shield_regeneration_time > 0:
		shield_regeneration_time -= delta

		if shield_regeneration_time <= 0:
			shield_time = SHIELD_DURATIOM
			shielding_bar.value = shield_time

	# Activating shield for player
	if shielding == true:
		if not Input.is_action_pressed("ui_shield"):
			shielding = false
			show_shielding.visible = false
		else:
			shield_time -= delta
			shielding_bar.value = shield_time
			
			# Regenerates the shield after the regeneration time has finished
			if shield_time <= 0:
				shield_time == 0
				shielding = false
				shield_cooldown_time = SHIELD_COOLDOWN
				shield_regeneration_time = SHIELD_REGENERATION
				show_shielding.visible = false

	# Activate shield
	elif shield_cooldown_time <= 0 and shield_regeneration_time <= 0:
		if Input.is_action_pressed("ui_shield"):
			shielding = true
			show_shielding.visible = true

	# Used to control gravity and resetting double jump
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		double_jump = true  

	# Handle double jump
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			double_jump = true
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false

# Horizontal movement 
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# Checks what happens when the player takes damage
func take_damage(damage: int) -> void:
	if shielding == true:
		return
	elif health <= 0:
		get_tree().call_deferred("reload_current_scene")
	else:
		health -= damage
		health_ui.value = health


# Checks when an enemy enters the player's attack range
func _attack(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy = body 
		enemy_range = true


# Teleports the player within the scene
func _portal(area: Area2D) -> void:
	if area.is_in_group("Portal"):
		position.x = TELEPORT_XVALUE
		position.y = TELEPORT_YVALUE
		teleport_count += teleport_increase
		
		if teleport_count >= TELEPORT_REQUIRMENT:
			get_tree().change_scene_to_file("res://scene/End_Animation.tscn")


# Detects when an enemy leaves the player's attack range
func _exit_body(body: Node2D) -> void:
	enemy_range = false
	
