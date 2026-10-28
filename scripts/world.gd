extends Control

@onready var popup: Control = $popup

func _ready() -> void:
	SignalHandler.round_end.connect(_on_round_end)
	
	
func _on_round_end():
	popup.show()
