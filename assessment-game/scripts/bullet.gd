extends Area2D

var speed: float = 1300

func _process(delta: float) -> void:
	move_local_x(speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()	
