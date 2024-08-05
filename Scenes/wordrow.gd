extends Control

@onready var Box0 = $Box0/Label
@onready var Box1 = $Box1/Label
@onready var Box2 = $Box2/Label
@onready var Box3 = $Box3/Label
@onready var Box4 = $Box4/Label
@onready var boxes : Array = [Box0, Box1, Box2, Box3, Box4]

@export var keyboard: Control
@export var main: Control

var current_box : int = 0


func _ready():
	for child in keyboard.get_children():
		child.keyboard_button.connect(keyboard_input)

func keyboard_input(button):
	if button not in ["Delete", "Enter"] and Box4.text == "":
		boxes[current_box].text = button
		current_box += 1
	
	if button == "Delete":
		boxes[current_box - 1].text = ""
		current_box -= 1
		if current_box < 0:
			current_box = 0
	
	if button == "Enter":
		if Box4.text == "":
			print("Not enough Letters")
		else:
			check_word()

func check_word():
	var solution = main.word
	var word_list = main.word_list
	var word = ""
	for box in boxes:
		word += box.text.to_lower()
	if word not in word_list:
		print("word does not exist")
	else:
		for i in range(5):
			reveal(boxes[i].text.to_lower(), solution[i], boxes[i], solution)

func reveal(attempt_letter, solution_letter, box, solution):
	var yellow = Color(.75,.75,.0,1)
	var green = Color(0,.80,0,1)
	var gray = Color(.30, .30, .30, 1)
	var this_box = box.get_parent()
	if attempt_letter != solution_letter:
		if attempt_letter in solution:
			# Yellow
			this_box.color = yellow
		else:
			# Gray
			this_box.color = gray
	else:
		# Green
		this_box.color = green
