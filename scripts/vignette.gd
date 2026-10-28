extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide() # Add this line of code to the world node and not itself.
	SignalHandler.complete.connect(on_complete)
	
func on_complete():
	show()
	animation_player.play("pulse")
	await animation_player.animation_finished
	hide()
