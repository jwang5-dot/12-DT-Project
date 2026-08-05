extends Node2D

const SPWAN_TIME: int = 1
const ENEMY_NUMBER: int = 4

@export var enemy_scene: PackedScene
@export var spawn_point: Marker2D
@export var spawn_timer: Timer

var enemy_spawned: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn_timer = SPWAN_TIME
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
