extends Area2D


@export var landing_zone : Area2D
var teleport_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var tp_point = landing_zone.get_node("Marker2D").global_position
	body.global_position = tp_point
	teleport_count += 1
	
	if teleport_count >= 3:
		get_tree().change_scene_to_file("res://scene/End_Animation.tscn")
		
