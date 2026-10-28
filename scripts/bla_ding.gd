extends AudioStreamPlayer

@onready var bla_ding: AudioStreamPlayer = $"."

func _ready() -> void:
	SignalHandler.complete.connect(on_complete)
	
func on_complete():
	bla_ding.play()
