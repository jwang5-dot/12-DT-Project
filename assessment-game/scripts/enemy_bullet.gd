extends Area2D

# Stores how quickly the enemy bullet moves.
var speed: float = 1500

# Stores the amount of damage the enemy bullet deals to a player.
var damage: int = 10


func _process(delta: float) -> void:
	move_local_x(speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body is Player_1 or body is Player_2:
		body.take_damage(damage)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	pass
