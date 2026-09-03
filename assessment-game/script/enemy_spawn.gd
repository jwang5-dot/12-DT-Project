extends Node2D

const SPAWN_TIME: int = 1
const ENEMY_NUMBER: int = 1
const ENEMY_WAVES: int = 3
const WAVE_TIME: int = 10
const ENEMY_SPAWNED = 0
const WAVE_INCREASE = 1

@export var enemy_scene: Array[PackedScene]
@export var spawn_point: Marker2D
@export var spawn_timer: Timer
@export var wave_timer: Timer

var enemy_spawned: int = 0
var enemy_increased: int = 1
var enemy_wave: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = SPAWN_TIME
	spawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _timer_countdown() -> void:
	if enemy_spawned <= ENEMY_NUMBER and enemy_wave < 2:
		spawn_enemy()
		enemy_spawned += enemy_increased
	else:
		spawn_timer.stop()
		await get_tree().create_timer(WAVE_TIME).timeout
		enemy_spawned = ENEMY_SPAWNED
		enemy_wave += WAVE_INCREASE
		spawn_timer.start()
		
func spawn_enemy() -> void:
	var random_spawn = randi_range(0, len(enemy_scene) - 1)
	var enemy = enemy_scene[random_spawn].instantiate()
	enemy.global_position = spawn_point.global_position
	get_parent().add_child(enemy)
		
