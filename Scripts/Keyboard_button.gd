extends Button

signal keyboard_button(button_text)

func _input(event):
	if event.is_action_pressed(self.text):
		_on_pressed()

func _on_pressed() -> void:
	keyboard_button.emit(self.text)

