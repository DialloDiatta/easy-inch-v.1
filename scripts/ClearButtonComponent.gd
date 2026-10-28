extends Node2D
class_name ClearButtonComponent

@export var clear_button: TextureButton
@onready var blocks = $".."

func _ready() -> void:
	clear_button.pressed.connect(_on_clear_button_pressed)

func _on_clear_button_pressed() -> void:
	SignalHandler.clear.emit()
	
	#var buttons : Array = buttons_parent.find_children("*", "TextureButton", true, false)
	#for child in blocks.get_children():
		#if child != self:
			#child.queue_free()
	#for button in buttons:
		#button.clear()
		
