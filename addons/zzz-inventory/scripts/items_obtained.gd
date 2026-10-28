extends Control

@onready var items_obtained_container: HBoxContainer = $PanelContainer/MarginContainer/CenterContainer/VBoxContainer/ItemsObtained
@onready var label: Label = %Label



func _ready() -> void:
	#Items.items_obtained.connect(_on_items_obtained)
	clear_grid_container()
	SignalHandler.finalize_score.connect(on_finalize_score)
	SignalHandler.new_highscore.connect(on_new_highscore)

func _on_button_pressed() -> void:
	self.hide()
	SignalHandler.round_start.emit()

#TODO Uncomment and gix errors.
#func add_item_cell(slot: InventorySlot):
	#var item_cell = Items.item_cell_scene.instantiate()
	#items_obtained_container.add_child(item_cell)
	#item_cell.set_item(slot)

func clear_grid_container():
	while items_obtained_container.get_child_count() > 0:
		var child = items_obtained_container.get_child(0)
		items_obtained_container.remove_child(child)
		child.queue_free()

func on_finalize_score(score):
	label.text = "Score: " + str(score)
	print("Text changed")
	
func on_new_highscore():
	label.text = "New HighScore: " + str(global.high_score)
