extends Control

signal next_row(word)
signal header_update(header)
signal key_colorchange(color, letter)

@onready var boxes : Array = [$Box0/Label, $Box1/Label, $Box2/Label, $Box3/Label, $Box4/Label]

@export var keyboard: Control
@export var main: Control

var active : bool = false
var current_box : int = 0


func _ready() -> void:
	for child in keyboard.get_children():
		child.keyboard_button.connect(keyboard_input)
		child.connect_keyboard_color_signal(self)


func keyboard_input(button : String) -> void:
	if active:
		if button not in ["Delete", "Enter"] and boxes[-1].text == "":
			boxes[current_box].text = button
			current_box += 1
		
		if button == "Delete":
			boxes[current_box - 1].text = ""
			current_box -= 1
			if current_box < 0:
				current_box = 0
		
		if button == "Enter":
			if boxes[-1].text == "":
				header_update.emit("Not Enough Letters")
			else:
				check_word()


func check_word() -> void:
	var solution : String = main.word
	var word_list : Array = main.word_list
	var word = ""
	for box in boxes:
		word += box.text.to_lower()
	if word not in word_list:
		header_update.emit("Not in word list")
	else:
		for i in range(5):
			reveal(boxes[i].text.to_lower(), solution[i], boxes[i], solution)
		active = false
		next_row.emit(word)


func reveal(attempt_letter, solution_letter, box, solution) -> void:
	var yellow : Color = Color(0.75, 0.75, .0, 1)
	var green : Color = Color(0, 0.80, 0, 1)
	var gray : Color = Color(0.30, 0.30, 0.30, 1)
	var this_box : Node = box.get_parent()
	var border : Node = this_box.get_child(1)
	if attempt_letter != solution_letter:
		if attempt_letter in solution:
			# Yellow
			this_box.color = yellow
			key_colorchange.emit("yellow", attempt_letter)
		else:
			# Gray
			this_box.color = gray
			key_colorchange.emit("gray", attempt_letter)
	else:
		# Green
		this_box.color = green
		key_colorchange.emit("green", attempt_letter)
	border.hide()
	
