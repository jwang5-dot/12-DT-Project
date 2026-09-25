extends Label

const WAVE_TEXT = "Wave "
const INVALID_WAVE_TEXT = "Invalid"
const WAVE_INCREASED: int = 1


# To print an output to the user showing what wave they are on
func _wave_changed(wave: Variant) -> void:
	if wave is int and wave >= WAVE_INCREASED:
		text = WAVE_TEXT + str(wave)
	else:
		text = WAVE_TEXT + INVALID_WAVE_TEXT
