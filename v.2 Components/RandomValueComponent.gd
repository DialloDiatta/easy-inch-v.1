extends Control

@export var refresh_button: TextureButton
@export_range(0, 16, 1, "or_greater", "or_less") var lowest: int
@export_range(0, 16,  1, "or_greater", "or_less") var highest: int
@export var label: Label

@onready var settings: VBoxContainer = $Settings


var rng = RandomNumberGenerator.new()
var last_number: int = -1


func _ready() -> void:
	settings.set_val.connect(set_range)
	refresh_button.pressed.connect(on_refresh_pressed)
	SignalHandler.complete.connect(on_complete)
	SignalHandler.round_start.connect(on_round_start)

# Handles input for when random() is triggered. 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("refresh"):
		on_refresh_pressed()
	#Test Mouse Click Triggers
	#if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			#random()
	# Connects Component to Button
	
# Parameters for random function.
func random():
	rng.randomize()
	var new_number = rng.randi_range(lowest, highest)
	
	while new_number == last_number:
		new_number = rng.randi_range(lowest, highest)
		
	last_number = new_number
	print(new_number)
	 
	# Labels can only print strings. So the new_number: int need's to converted into a string using str()
	label.text = str(new_number)
	
	SignalHandler.set_goal.emit(new_number)
	
func on_refresh_pressed():
	random()
	var blocks = get_tree().get_nodes_in_group("blocks")
	for node in blocks:
		node.queue_free()
	
func on_complete():
	on_refresh_pressed()

func set_range(value, slider_id):
	if slider_id == "max":
		highest = value
	elif slider_id == "min":
		lowest = value
	print("Higest: ", highest, "Lowest: ", lowest)

func on_round_start():
	on_refresh_pressed()
