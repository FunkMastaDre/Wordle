extends Button

signal keyboard_button(button_text)

func _ready() -> void:
	if text == "Enter":
		$ColorRect.size.x = 48
	if text == "Delete":
		$ColorRect.size.x = 56

func _input(event) -> void:
	if event.is_action_pressed(self.text):
		_on_pressed()

func connect_keyboard_color_signal(wordrow):
	wordrow.key_colorchange.connect(change_color)

func _on_pressed() -> void:
	keyboard_button.emit(self.text)

func change_color(color, letter) -> void:
	var yellow : Color = Color(0.75, 0.75, .0, 0.50)
	var green : Color = Color(0, 0.80, 0, 0.50)
	var gray : Color = Color(0.30, 0.30, 0.30, 0.50)
	
	if letter == text.to_lower():
		if color == "yellow":
			$ColorRect.color = yellow
		elif color == "green":
			$ColorRect.color = green
		else:
			$ColorRect.color = gray
