extends Control

@export var tutorial_resource : TutorialPack

@onready var steps = tutorial_resource.steps

@onready var title: Label = %TutorialTitle
@onready var instruction: Label = %Instruction
@onready var tut_vid: VideoStreamPlayer = %TutVid
@onready var previous: Button = %Previous
@onready var next: Button = %Next
@onready var close: Button = %Close
@onready var scroll_container: ScrollContainer = $PopUp/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/TextField/ScrollContainer


var slide_index = 0

func _ready() -> void:
	populate_slide()
	close.disabled = false

func populate_slide():
	var current_step = steps[slide_index]
	
	title.text = current_step.title
	instruction.text = current_step.instruction
	tut_vid.stream = current_step.video
	tut_vid.play()
# func update_buttons_states():
	previous.disabled = slide_index == 0
	# next.disabled = slide_index == steps.size() - 1
	
	if slide_index == steps.size() - 1:
		next.text = "Close"
		# Enables the close button at the last slide if it's currently disabled.
		if close.disabled:
			enable_close_button()
	else:
		next.text = "Next"
	
	

func _on_next_pressed() -> void:
	if slide_index == steps.size() - 1:
		_on_close_pressed()
	else:
		slide_index += 1
		populate_slide()
	
	# resets the scroll container to the top so content start can be seen.
	scroll_container.scroll_vertical = 0 

func _on_previous_pressed() -> void:
	slide_index -= 1
	populate_slide()

func _on_close_pressed() -> void:
	SignalHandler.round_start.emit()
	self.queue_free()
	
func enable_close_button():
	# Might add an animation to the button later. Code will go here.
	close.disabled = false
