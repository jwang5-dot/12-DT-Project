extends Area2D

var speed: float = 1500

func _process(delta: float) -> void:
	move_local_x(speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body is Player_1:
		body.take_damage()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	pass
