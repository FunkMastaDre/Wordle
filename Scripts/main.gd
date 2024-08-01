extends Control



func _ready() -> void:
	# Read text file and add to words array.
	var word_list : Array = []
	var file = FileAccess.open("res://words.txt", FileAccess.READ)
	while file.get_position() < file.get_length():
		word_list.append(file.get_line())
	
	# Pick random word.
	var word = word_list.pick_random()
	print(word)
