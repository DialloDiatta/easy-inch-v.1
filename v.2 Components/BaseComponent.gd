class_name BaseComponent
extends Node2D
# The below code loads a new block into memory (new_block) then assigns a variable for any new instances of that block (new_instance)
@onready var new_block = $"..".new_block

func _ready():
	%Area2D.input_event.connect(_on_area_2d_input_event)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# creates the new block. 
			# I had to remove the selected = true code from here so it only affects the new instances.
			
			var new_instance = new_block.instantiate()
			# The below code was redundant because selected = true already sets the position for us.
			# new_instance.position = get_global_mouse_position()
			# This code adds the new instance into the blocks node in the root game tree.
			get_node("/root/world/Blocks").add_child(new_instance)
			new_instance.add_to_group("blocks") # Add the new instance to the "blocks" group
			new_instance.position = get_global_mouse_position()
			new_instance.get_node("DragComponent").draggable = true
			#Test to see if block was actually added to the group.
			#new_instance.draggable = true
			#if new_instance.is_in_group("blocks"):
				#print("New instance successfully added to the 'blocks' group")
			#else:
				#print("Failed to add the new instance to the 'blocks' group")
			print("Created")
			
