## Typocalypse
## Bornhack Gamejam 2024

extends Node2D
var Enemy = preload("res://scenes/Enemy.tscn")

var player_score = 0
var player_correct_types = 0
var player_mistypes = 0

# SOUNDS
@onready var wrongSFX = $WrongSFX
@onready var goodSFX = $GoodSFX

@onready var timer = $Timer
@onready var scoreboard = $Scoreboard
@onready var camera = $Camera2D
@onready var enemy_container = $EnemyContainer

var active_enemy = null
var current_letter_index: int = -1

func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		var next_character = prompt.substr(0,1)
		if next_character == typed_character:
			active_enemy = enemy
			current_letter_index = 1
			player_correct_types += 1
			active_enemy.set_next_character_color(current_letter_index)
			return # Only choose the first enemy.
		else:
			player_mistypes += 1
			wrongSFX.play()
			camera.apply_shake()
		draw_score_and_more()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		if active_enemy == null:
			find_new_active_enemy(key_typed)
		else:
			var prompt = active_enemy.get_prompt()
			var next_character = prompt.substr(current_letter_index, 1)
			if key_typed == next_character:
				current_letter_index += 1
				active_enemy.set_next_character_color(current_letter_index)
				player_correct_types += 1
				if current_letter_index == prompt.length():
					current_letter_index = -1
					player_correct_types += 1
					active_enemy.queue_free()
					active_enemy = null

					# Add point
					goodSFX.play()
					player_score += 1
					update_difficulty()
			else:
				wrongSFX.play()
				camera.apply_shake()
				player_mistypes += 1
		draw_score_and_more()

func draw_score_and_more() -> void:
	scoreboard.text = "SCORE: %d\nMISTYPES: %d" % [
		player_score,
		player_mistypes,
	]

func _process(delta):
	#Dynamic time shift.
	timer.wait_time -= delta * 0.01

func _ready():
	invert_viewport()
	randomize()
	spawn_enemy()
	draw_score_and_more()
	emit_signal("diffup")
	

func _on_timer_timeout():
	spawn_enemy()

var spawn_ban: float

func spawn_enemy() -> void:
	#TODO: Implement some logic to spread out a bit.?
	var enemy_instance = Enemy.instantiate()
	enemy_container.add_child(enemy_instance)
	enemy_instance.global_position = Vector2(
		get_viewport_rect().size.x,
		randi_range(
			100,
			get_viewport_rect().size.y-100,
		)
	)

func invert_viewport() -> void:
	# Upside down whoo!
	camera.zoom.y = -camera.zoom.y
	camera.zoom.x = -camera.zoom.x


func _on_lose_zone_area_entered(area):
	# Game shits itself if word reaches the end.
	GlobalVars.final_score = player_score
	GlobalVars.final_mistypes = player_mistypes
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")


# Ungodly code, but seems to work.
func increment_difficulty() -> void:
	GlobalVars.difficulty += 1

func update_difficulty():
		match player_score:
			2: increment_difficulty()
			4: increment_difficulty()
			6: increment_difficulty()
			8: increment_difficulty()
			10: increment_difficulty()
			12: increment_difficulty()
			14: increment_difficulty()
			16: increment_difficulty()
			18: increment_difficulty()
			20: increment_difficulty()
			22: increment_difficulty()
			24: increment_difficulty()
			26: increment_difficulty()
			28: increment_difficulty()
			29: increment_difficulty()
			# Timeshift should do the rest.
	
