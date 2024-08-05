extends Control

var word_list : Array
var word : String

func _ready() -> void:
	# Read text file and add to words array.
	
	var file = FileAccess.open("res://words.txt", FileAccess.READ)
	while file.get_position() < file.get_length():
		word_list.append(file.get_line())
	
	# Pick random word.
	word = word_list.pick_random()
	print(word)
