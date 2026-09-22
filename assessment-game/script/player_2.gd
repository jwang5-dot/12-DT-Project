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

func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health 
	show_shielding.visible = false
	
	shielding_bar.max_value = SHIELD_DURATIOM
	shielding_bar.value = SHIELD_DURATIOM

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
		
# Shield cooldown
	if shield_cooldown_time > 0:
		shield_cooldown_time -= delta

	# Shield regeneration
	if shield_regeneration_time > 0:
		shield_regeneration_time -= delta

		if shield_regeneration_time <= 0:
			shield_time = SHIELD_DURATIOM
			shielding_bar.value = shield_time

	# Shield active
	if shielding == true:
		if not Input.is_action_pressed("ui_shield"):
			shielding = false
			show_shielding.visible = false
		else:
			shield_time -= delta
			shielding_bar.value = shield_time
			
			if shield_time <= 0:
				shield_time = 0
				shielding = false
				shield_cooldown_time = SHIELD_COOLDOWN
				shield_regeneration_time = SHIELD_REGENERATION
				show_shielding.visible = false

	# Activate shield
	elif shield_cooldown_time <= 0 and shield_regeneration_time <= 0:
		if Input.is_action_pressed("ui_shield"):
			shielding = true
			show_shielding.visible = true
		
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
	
func take_damage(damage: int) -> void:
	if shielding == true:
		return
	elif health <= 0:
		get_tree().call_deferred("reload_current_scene")
	else:
		health -= damage
		health_ui.value = health


func _attack(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy = body 
		enemy_range = true


func _portal(area: Area2D) -> void:
	if area.is_in_group("Portal"):
		position.x = TELEPORT_XVALUE
		position.y = TELEPORT_YVALUE
		teleport_count += teleport_increase
		
		if teleport_count >= 2:
			get_tree().change_scene_to_file("res://scene/End_Animation.tscn")


func _exit_body(body: Node2D) -> void:
	enemy_range = false
	
