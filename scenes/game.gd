extends Node2D

var hiragana_list = [
	# Vowels
	{"hiragana": "あ", "romaji": "a"},
	{"hiragana": "い", "romaji": "i"},
	{"hiragana": "う", "romaji": "u"},
	{"hiragana": "え", "romaji": "e"},
	{"hiragana": "お", "romaji": "o"},
	# K row
	{"hiragana": "か", "romaji": "ka"},
	{"hiragana": "き", "romaji": "ki"},
	{"hiragana": "く", "romaji": "ku"},
	{"hiragana": "け", "romaji": "ke"},
	{"hiragana": "こ", "romaji": "ko"},
	# S row
	{"hiragana": "さ", "romaji": "sa"},
	{"hiragana": "し", "romaji": "shi"},
	{"hiragana": "す", "romaji": "su"},
	{"hiragana": "せ", "romaji": "se"},
	{"hiragana": "そ", "romaji": "so"},
	# T row
	{"hiragana": "た", "romaji": "ta"},
	{"hiragana": "ち", "romaji": "chi"},
	{"hiragana": "つ", "romaji": "tsu"},
	{"hiragana": "て", "romaji": "te"},
	{"hiragana": "と", "romaji": "to"},
]

var current_score = 0:
	set(value):
		current_score = value
		$ScoreLabel.text = str(value)  # Convert to string!

var current_item = null:
	set(value):
		current_item = value
		if value:  # Add null check for safety
			$KataDisplay.text = value.hiragana

func _ready() -> void:
	current_item = hiragana_list.pick_random()
		
	await get_tree().create_timer(1).timeout
	
	pick_new_item()
	
	$MainInput.grab_focus()
	$MainInput.text_changed.connect(_on_text_changed)
	
func _on_text_changed(new_text: String) -> void:
	if new_text == current_item.romaji:
		$Ninja.animate_cut()
		
		await get_tree().create_timer(0.65).timeout
		
		$MainInput.clear()
		pick_new_item()
		current_score += 1
		
func pick_new_item():
	current_item = hiragana_list.pick_random()
