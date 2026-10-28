class_name ClearComponent
extends Node2D

@onready var actor = $".."

func _ready():
	%Area2D.input_event.connect(_on_area_2d_input_event)
	%Area2D.body_entered.connect(_on_area_2d_body_entered)
	%Area2D.body_exited.connect(_on_area_2d_body_exited)

# Clear All Script
func _input(_event):
	if Input.is_action_just_pressed("clear"):
		actor.queue_free()
		print("clear all")
		
#Clear Single
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			actor.queue_free()
			print("clear single")
			
func _on_area_2d_body_entered(body):
	if body.is_in_group('trashcan'):
		if body.overlaps_area():
			actor.queue_free()
			print("Entered Trashcan")
	
func _on_area_2d_body_exited():
	pass
