extends Button

signal keyboard_button(button)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_pressed() -> void:
	keyboard_button.emit(text)

