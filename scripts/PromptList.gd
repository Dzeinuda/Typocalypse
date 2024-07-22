extends Node

var four_letters = FileAccess.open(
	'res://wordlists/four_letters.txt',
	FileAccess.READ,
)

var five_letters = FileAccess.open(
	'res://wordlists/five_letters.txt',
	FileAccess.READ,
)

var six_letters = FileAccess.open(
	'res://wordlists/six_letters.txt',
	FileAccess.READ,
)

var seven_letters = FileAccess.open(
	'res://wordlists/seven_letters.txt',
	FileAccess.READ,
)

var eight_letters = FileAccess.open(
	'res://wordlists/eight_letters.txt',
	FileAccess.READ
)

var wordlists = {
	"four": four_letters,
	"five": five_letters,
	"six": six_letters,
	"seven": seven_letters,
	"eight": eight_letters,
}

func fetch_word(difficulty) -> String:
	var words = wordlists[difficulty].get_as_text().split("\n")
	var word_index = randi() % words.size()
	return words[word_index].to_lower()
