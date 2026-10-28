extends Node

var current_value : int
var current_goal : int

func _ready() -> void:
	SignalHandler.add.connect(adjust_current_value)
	SignalHandler.set_goal.connect(set_goal)
	
func set_goal(new_goal: int):
	# New goal is coming from current RandomValueComponent Script.
	current_goal = new_goal
	current_value = 0
	print("New Goal: ", current_goal)
	
func adjust_current_value(adjustment: int):
	current_value += adjustment
	if current_value <= 0:
		current_value = 0
	if current_value == current_goal:
		SignalHandler.complete.emit()
	print(current_value)
	
