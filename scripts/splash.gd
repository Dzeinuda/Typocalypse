extends Node2D

@onready var musplayer = $AudioStreamPlayer2D

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.as_text() == "Shift+Space":
			get_tree().change_scene_to_file("res://scenes/Main.tscn")
			
			
func _ready():
	musplayer.play()
