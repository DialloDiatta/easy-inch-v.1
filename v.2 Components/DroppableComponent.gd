class_name DroppableComponent
extends Node2D


var is_inside_dropzone = false
var body_ref
@onready var parent = $".."


func _ready():
	%Area2D.body_entered.connect(_on_area_2d_body_entered)
	%Area2D.body_exited.connect(_on_area_2d_body_exited)
	


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropzone'):
		is_inside_dropzone = true
		body.modulate = Color(Color.GREEN , 1)
		body_ref = body
		body.full = true
		print("Ready to fill")
		
func _on_area_2d_body_exited(body):
	if body.is_in_group('dropzone'):
		is_inside_dropzone = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
		body.full = false
		print("Not yet")


func _process(_delta):
	if Input.is_action_just_released("click"):
		if is_inside_dropzone and body_ref.full == true:
			print("Ready to fill") 
			var tween = get_tree().create_tween()
			tween.tween_property(parent, "position", body_ref.position,0.2) .set_ease(Tween.EASE_OUT) .set_trans(Tween.TRANS_QUAD)
			body_ref.full = false
			print("body has been filled")
		elif is_inside_dropzone and body_ref.full != true:
			print("This box is full!")
