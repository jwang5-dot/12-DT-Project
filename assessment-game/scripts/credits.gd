extends Control


# Called when the credits screen enters the scene tree for the first time.
func _ready() -> void:
	pass # No code is currently required when the screen starts.


# Called every frame while the credits screen is active.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	# Returns to the main menu when the button is pressed.
	Transition.transition_to("res://scene/mainmenu.tscn")
