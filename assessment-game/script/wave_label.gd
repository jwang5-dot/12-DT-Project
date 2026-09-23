extends Label

const WAVE_TEXT = "Wave "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# To print an output to the user showing what wave they are on
func _wave_changed(wave: Variant) -> void:
	text = WAVE_TEXT + str(wave)
