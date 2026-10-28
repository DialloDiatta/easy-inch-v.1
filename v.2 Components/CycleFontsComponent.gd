extends Control
class_name CycleFontsComponent


@export var label: Label
var fonts = {
	"regular": load("res://fonts/Inches.otf"),
	"square": load("res://fonts/Inches-Square.otf"),
	#"linear": load("res://fonts/Inches-Linear.otf"),
}

var font_keys = fonts.keys()
#Make sure to update this range when adding more fonts. 
@export_range(0, 1) var current_font_index: int
@export var change_font_button: TextureButton
@export var refresh_button: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_current_font()
	
	change_font_button.pressed.connect(on_change_font_pressed)
	refresh_button.pressed.connect(on_refresh_pressed)

func cycle_font():
	# Increment font index, wrapping around to start if needed
	current_font_index = (current_font_index + 1) % font_keys.size()
	apply_current_font()	
	
func apply_current_font():
	# Get the current font key and apply its corresponding font
	var current_key = font_keys[current_font_index]
	label.add_theme_font_override("font", fonts[current_key])
	print("Current Key:", fonts[current_key])

# Example of how to call font cycling (e.g., on a button press)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("CycleFonts"):
		cycle_font()
		print("Current Font Index:", current_font_index)
		change_font_button.set_pressed(current_font_index != 0)


	if event.is_action_pressed("refresh"):
		on_refresh_pressed()

func on_change_font_pressed():
	cycle_font()
	
func on_refresh_pressed():
	current_font_index = font_keys.find("regular")
	apply_current_font()
	change_font_button.set_pressed(false)
