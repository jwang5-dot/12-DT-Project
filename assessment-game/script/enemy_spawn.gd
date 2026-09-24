extends Node2D

signal wave_changed(wave)

const SPAWN_TIME: int = 1
const ENEMY_NUMBER: int = 1
const ENEMY_WAVES: int = 2
const WAVE_TIME: int = 10
const ENEMY_SPAWNED = 0
const WAVE_INCREASE = 1

@export var enemy_scene: Array[PackedScene]
@export var spawn_point: Marker2D
@export var spawn_timer: Timer
@export var wave_timer: Timer

var enemy_spawned: int = 0
var enemy_increased: int = 1
var enemy_wave: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = SPAWN_TIME
	spawn_timer.start()


# Timer used to control when the enemy spawns and starts a new wave
func _timer_countdown() -> void:
	# Checks and spawns an amount of enemies
	if enemy_spawned <= ENEMY_NUMBER and enemy_wave <= ENEMY_WAVES:
		spawn_enemy()
		enemy_spawned += enemy_increased
	else:
		spawn_timer.stop()

		# Updates the wave number displayed, resets the enemy spawed and starts new wave
		if enemy_wave < ENEMY_WAVES:
			await get_tree().create_timer(WAVE_TIME).timeout
			enemy_spawned = ENEMY_SPAWNED
			enemy_wave += WAVE_INCREASE
			wave_changed.emit(enemy_wave)
			spawn_timer.start()


# Randomly spawns enemies in the Packed scene 
func spawn_enemy() -> void:
	var random_spawn = randi_range(0, len(enemy_scene) - 1)
	var enemy = enemy_scene[random_spawn].instantiate()
	enemy.global_position = spawn_point.global_position
	get_parent().add_child(enemy)
	
