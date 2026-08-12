extends Node2D

const SPAWN_TIME: int = 1
const ENEMY_NUMBER: int = 3

@export var enemy_scene: Array[PackedScene]
@export var spawn_point: Marker2D
@export var spawn_timer: Timer

var enemy_spawned: int = 0
var enemy_increased: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = SPAWN_TIME
	spawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _timer_countdown() -> void:
	if enemy_spawned <= ENEMY_NUMBER:
		spawn_enemy()
		enemy_spawned += enemy_increased
	else:
		spawn_timer.stop()
		
func spawn_enemy() -> void:
	var enemy = enemy_scene[1].instantiate()
	enemy.global_position = spawn_point.global_position
	get_parent().add_child(enemy)
		
