extends Button

signal keyboard_button(button_text)

func _on_pressed() -> void:
	keyboard_button.emit(self.text)

