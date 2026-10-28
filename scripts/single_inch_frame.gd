extends CenterContainer


func get_active_buttons():
	var buttons = find_children("*", "TextureButton", true, false)
	var active_buttons: float = 0.0
	for button in buttons:
		if button.button_pressed:
			active_buttons += 1
	print("Active Buttons: ", active_buttons)
	return active_buttons
			
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		print("We have ", get_active_buttons(), " buttons active.")
