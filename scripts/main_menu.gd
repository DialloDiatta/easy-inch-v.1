extends Control

func _on_double_inch_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/double_inch_interface.tscn")



func _on_single_inch_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/beginner_tutorial.tscn")




func _on_random_inch_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/single_inch_random.tscn")
