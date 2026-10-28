extends Label

func _ready() -> void:
	SignalHandler.add.connect(on_add)
	GoalManager.current_goal = 63 # Just some number that can't be reached.
	
func on_add(adjustment): # "adjustment" isn't needed and never used.
	self.text = str(GoalManager.current_value)
