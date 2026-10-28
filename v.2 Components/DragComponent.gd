class_name DragComponent
extends Node2D

#@export var actor: Node2D
@onready var actor = $".."

var draggable = false
var offset: Vector2
var initialPos : Vector2

func _ready():
	%Area2D.mouse_entered.connect(_on_area_2d_mouse_entered)
	%Area2D.mouse_exited.connect(_on_area_2d_mouse_exited)

func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			print("click")
			initialPos = actor.global_position
			offset = get_global_mouse_position() - actor.global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			actor.global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			
func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		actor.scale = Vector2(1.05, 1.05)
		print("Entered")
		print(draggable)

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		actor.scale = Vector2(1, 1)
		print("Exited")
		print(draggable)
		
		
