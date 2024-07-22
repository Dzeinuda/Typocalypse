extends Node2D

@onready var score_tally = $TextureRect/Score
@onready var mistype_tally = $TextureRect/Mistypes
@onready var camera = $Camera2D

func _ready():
	invert_viewport()
	score_tally.parse_bbcode("[center]Score: [color=green]%d[/color][/center]" % GlobalVars.final_score)
	mistype_tally.parse_bbcode("[center]Errors: [color=red]%d[/color] [/center]" % GlobalVars.final_mistypes)

func invert_viewport() -> void:
	# Upside down whoo!
	camera.zoom.y = -camera.zoom.y
	camera.zoom.x = -camera.zoom.x

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.as_text() == "R":
			GlobalVars.difficulty = 1
			get_tree().change_scene_to_file("res://scenes/Main.tscn")
