extends Control

const MAIN_MENU_SCENE = "res://scene/mainmenu.tscn"


# Called when the controls screen enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame while the controls screen is active.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	# Returns to the main menu when the button is pressed.
	Transition.transition_to(MAIN_MENU_SCENE)
