## Typocalypse
## Bornhack Gamejam 2024

extends Sprite2D

@export var blue: Color  = Color()
@export var green: Color = Color()
@export var red: Color  = Color()

@export var base_speed: float = .8
@export var speed_modifier: float = 1.0
@export var current_difficulty: int = 1

@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text

func fetch_difficully_speed_modifier() -> float:
	return Difficulty.translate_difficulty(GlobalVars.difficulty)["speed_modifier"]

func fetch_diffulcty_wordlength() -> String:
	return Difficulty.translate_difficulty(GlobalVars.difficulty)["letters"]

func get_prompt() -> String:
	
	"""Can't find a way out of doing this.
	I need to strip bbcode before rendering 
	text to player"""
	
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	return regex.sub(prompt_text, "", true)

func _physics_process(_delta):
	global_position.x -= base_speed * fetch_difficully_speed_modifier()
	
func _ready():
	prompt_text = PromptList.fetch_word(
		fetch_diffulcty_wordlength()
	)
	prompt.parse_bbcode("[center]" + prompt_text + "[/center]")

func set_next_character_color(next_character_index: int) -> void:
	var blue_text = get_bbcode_color_tag(blue) + \
					get_prompt().substr(0, next_character_index) + \
					get_bbcode_end_tag() # Color all text blue.
	
	var green_text = get_bbcode_color_tag(green) + \
					get_prompt().substr(next_character_index, 1) + \
					get_bbcode_end_tag() # Color current next char green.

	var red_text = "" # Assume we are at the end of the word.
	if next_character_index != get_prompt().length():
		# If we are not, color the rest of the string red.
		red_text = get_bbcode_color_tag(red) + \
					get_prompt().substr(next_character_index + 1, get_prompt().length() - next_character_index + 1) + \
					get_bbcode_end_tag()
	
	prompt.parse_bbcode("[center]" + blue_text + green_text + red_text + "[/center]")
	
func get_bbcode_color_tag(color: Color) -> String:
	return "[color=" + color.to_html(false) + "]"
	
func get_bbcode_end_tag() -> String:
	return "[/color]"
