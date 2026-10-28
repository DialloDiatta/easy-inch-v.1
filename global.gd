extends Node2D

var is_dragging = false

var high_score: int = 0

var fullscreen: bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if Input.is_action_just_pressed("fullscreen"):
		if !fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = false
		
