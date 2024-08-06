extends Control

var word_list : Array
var word : String
var Wordrows : Array
var current_row = 0
var win_headers : Array = ["Perfect!", "Excellent!", "Great!", "Good!", "Ok!", "Close Call..."]


func _ready() -> void:
	# Read text file and add to words array.
	var file = FileAccess.open("res://words.txt", FileAccess.READ)
	while file.get_position() < file.get_length():
		word_list.append(file.get_line())
	
	# Pick random word.
	word = word_list.pick_random()
	print(word)
	
	# Create State controller
	for child in $Rows.get_children():
		Wordrows.append(child)
		child.next_row.connect(check_solution)
		child.header_update.connect(change_header)
	Wordrows[current_row].active = true
	
	# Focus keyboard
	$Keyboard/Q.grab_focus()


func check_solution(attempt) -> void:
	const max_rows = 6
	if word != attempt:
		current_row += 1
		if current_row > max_rows - 1:
			change_header(word)
			print("You Lose")
			$Play_again.show()
		else:
			await get_tree().create_timer(0.1).timeout
			Wordrows[current_row].active = true
	else:
		var header : String = win_headers[current_row]
		
		change_header(header)
		print("You Win!")
		$Play_again.show()


func change_header(header) -> void:
	$Header.text = header
	if header not in win_headers:
		$"Header/Header cooldown".start()


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_header_cooldown_timeout() -> void:
	if $Header.text not in win_headers:
		$Header.text = ""
