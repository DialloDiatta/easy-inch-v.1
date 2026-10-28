extends Button

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)
@export var color1 : Color = Color.RED
@export var color2 : Color = Color.BLUE
#@onready var panel: Panel = $Panel
#@onready var style_box = panel.get_theme_stylebox("theme_override_styles/panel")
#@onready var new_style_box = style_box.duplicate()
#@onready var label: Label = $Label
var pressing: bool = false
var tween: Tween
var color_tween: Tween
var original_pressed_stylebox: StyleBox

func _ready() -> void:
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	
	original_pressed_stylebox = get_theme_stylebox("pressed")
	call_deferred("_init_pivot")

func _init_pivot():
	pivot_offset = size / 2.0

#func _on_mouse_entered():
	#print("entered")
	#
#func _on_mouse_exited():
	#pass
	
func _on_pressed():
	var button_press_tween: Tween = create_tween()
	button_press_tween.tween_property(self, "scale", pressed_scale, 0.06).set_trans(Tween.TRANS_SINE)
	button_press_tween.tween_property(self, "scale", hover_scale, 0.12).set_trans(Tween.TRANS_SINE)
	
func _on_button_down():
	start_tween()
	start_color_tween()
	
func _on_button_up():
	stop_tween()
	stop_color_tween()
	
	var return_tween: Tween = create_tween()
	return_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_SINE)

func start_tween():
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_loops() # Loop infinitely
	
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.5).set_trans(Tween.TRANS_SINE) 
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.5).set_trans(Tween.TRANS_SINE)
	
func stop_tween():
	if tween:
		tween.kill()
	
func start_color_tween():
	if color_tween:
		color_tween.kill()
	
	color_tween = create_tween()
	color_tween.set_loops()
	
	color_tween.tween_method(set_pressed_color, color1, color2, 0.5)
	color_tween.tween_method(set_pressed_color, color2, color1, 0.5)
	
func stop_color_tween():
	if color_tween:
		color_tween.kill()
	
	# Remove the StyleBox override
	remove_theme_stylebox_override("pressed")

func set_pressed_color(color: Color):
	var new_style_box = original_pressed_stylebox.duplicate()
	new_style_box.bg_color = color
	add_theme_stylebox_override("pressed", new_style_box)
