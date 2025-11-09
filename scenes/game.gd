extends Node2D

const KataScene = preload("res://scenes/kata.tscn")

var GUESS_TIME = 10 

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
		$ScoreLabel.text = str(value)

var current_item = null
var current_kata_node = null

func _ready() -> void:
	pick_new_item()
	
	$MainInput.grab_focus()
	$MainInput.text_changed.connect(_on_text_changed)
	

func _process(delta) -> void:
	$"Timer label".text = str($GuessTimer.time_left).pad_decimals(1)

func _on_text_changed(new_text: String) -> void:
	if current_item and new_text == current_item.romaji:
		$Ninja.animate_cut()
		
		await get_tree().create_timer(0.2).timeout
		
		$Camera2D.shake()
		$MainInput.clear()
		
		if current_kata_node:
			current_kata_node.remove()
			current_kata_node = null
		
		pick_new_item()
		current_score += 1
		
func pick_new_item():
	$GuessTimer.start(GUESS_TIME)
	
	await get_tree().create_timer(0.4).timeout
	
	current_item = hiragana_list.pick_random()
	
	var center = get_viewport_rect().size / 2
	
	var kata = KataScene.instantiate()
	kata.setup($Camera2D.get_screen_center_position(), center, current_item.hiragana)
	
	add_child(kata)
	
	current_kata_node = kata


func _on_guess_timer_timeout() -> void:
	$HeartSystem.take_hit()
	
	if current_kata_node:
		current_kata_node.remove()
		current_kata_node = null
	
	pick_new_item()
	
