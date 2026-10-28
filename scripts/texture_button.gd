extends TextureButton
class_name Inch_Cell

@export var value : int 

func _ready() -> void:
	SignalHandler.complete.connect(clear)
	SignalHandler.clear.connect(clear)

func clear():
	if self.button_pressed:
		await get_tree().process_frame #This is necessary because the buttons get_active_buttons function will run after the button's been toggled off. 
		button_pressed = false # This emits a toggled signal.

func _toggled(state: bool):
	if state: # Piece Active
		SignalHandler.add.emit(value)
	if !state: # Piece Inactive
		SignalHandler.add.emit(-value)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("clear"):
		clear()
