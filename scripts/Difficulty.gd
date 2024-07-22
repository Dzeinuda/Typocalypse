extends Node

func translate_difficulty(difficulty: int) -> Dictionary:
	match difficulty:
		# Foru letters.
		1: return { "letters": "four", "speed_modifier": 1 }
		2: return { "letters": "four", "speed_modifier": 1.2 }
		3: return { "letters": "four", "speed_modifier": 1.4 }
		
		# Five letters.
		4: return { "letters": "five", "speed_modifier": 1.4 }
		5: return { "letters": "five", "speed_modifier": 1.4 }
		6: return { "letters": "five", "speed_modifier": 1.8 }
		
		# Six letters.
		7: return { "letters": "six", "speed_modifier": 1.8 }
		8: return { "letters": "six", "speed_modifier": 2.0 }
		9: return { "letters": "six", "speed_modifier": 2.0 }
		
		# Seven letters.
		10: return { "letters": "seven", "speed_modifier": 2.0 }
		11: return { "letters": "seven", "speed_modifier": 2.0 }
		12: return { "letters": "seven", "speed_modifier": 2.5 }
		
		# Eight letters.
		13: return { "letters": "eight", "speed_modifier": 3.0 }
		14: return { "letters": "eight", "speed_modifier": 3.0 }
		15: return { "letters": "eight", "speed_modifier": 3.5 }
		
		# Madness mode.
		_: return { "letters" : "eight", "speed_modifier": 4.0 }
