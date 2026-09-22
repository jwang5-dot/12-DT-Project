extends Area2D

# Stores how quickly the player's bullet moves.
var speed: float = 1300

func _process(delta: float) -> void:
	# Moves the bullet forward based on its speed and the time between frames.
	move_local_x(speed * delta)

func _on_body_entered(body: Node2D) -> void:
	# Checks whether the bullet has hit an enemy before dealing damage
	# and removing the bullet from the scene.
	if body.is_in_group("enemy"):
		body.take_damage()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Removes the bullet when it leaves the visible screen.
	queue_free()	
